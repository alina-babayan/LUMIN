#include "ApiClient.h"
#include "TokenStorage.h"
#include "ApiEndpoints.h"

#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonParseError>
#include <QDebug>

ApiClient* ApiClient::instance()
{
    static ApiClient* s = new ApiClient;
    return s;
}

ApiClient::ApiClient(QObject *parent)
    : QObject(parent)
{
    connect(&m_nam, &QNetworkAccessManager::finished, this, [this](QNetworkReply *reply) {
        QByteArray data = reply->readAll();
        QNetworkReply::NetworkError netError = reply->error();

        QJsonParseError jsonError{};
        QJsonDocument doc = QJsonDocument::fromJson(data, &jsonError);

        bool success = false;
        QString message, code;

        if (netError == QNetworkReply::NoError && jsonError.error == QJsonParseError::NoError) {
            auto obj = doc.object();
            success = obj["success"].toBool();
            message = obj["message"].toString();
            code = obj["code"].toString();
        } else {
            success = false;
            message = netError != QNetworkReply::NoError ? reply->errorString() : jsonError.errorString();
        }

        emit response(doc, success, message, code);
        reply->deleteLater();
    });
}

void ApiClient::sendRequest(QNetworkAccessManager::Operation op, const QString &endpoint, const QUrlQuery &query, const QByteArray &payload)
{
    QUrl url(ApiEndpoints::BASE_URL + endpoint);
    url.setQuery(query);

    QNetworkRequest req(url);
    req.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QString token = TokenStorage::instance()->accessToken();
    if (!token.isEmpty()) {
        req.setRawHeader("Authorization", ("Bearer " + token).toUtf8());
    }

    QNetworkReply *reply = nullptr;
    switch (op) {
    case QNetworkAccessManager::GetOperation:    reply = m_nam.get(req); break;
    case QNetworkAccessManager::PostOperation:   reply = m_nam.post(req, payload); break;
    case QNetworkAccessManager::PutOperation:    reply = m_nam.put(req, payload); break;
    case QNetworkAccessManager::DeleteOperation: reply = m_nam.deleteResource(req); break;
    default: Q_UNREACHABLE();
    }

    QString opName;
    switch (op) {
    case QNetworkAccessManager::GetOperation: opName = "GET"; break;
    case QNetworkAccessManager::PostOperation: opName = "POST"; break;
    case QNetworkAccessManager::PutOperation: opName = "PUT"; break;
    case QNetworkAccessManager::DeleteOperation: opName = "DELETE"; break;
    default: opName = "UNKNOWN"; break;
    }

    qDebug() << "API" << opName << url.toString() << (payload.isEmpty() ? "" : payload);
}

void ApiClient::get(const QString &endpoint, const QUrlQuery &query)
{ sendRequest(QNetworkAccessManager::GetOperation, endpoint, query, {}); }

void ApiClient::post(const QString &endpoint, const QJsonDocument &body)
{ sendRequest(QNetworkAccessManager::PostOperation, endpoint, {}, body.toJson(QJsonDocument::Compact)); }

void ApiClient::put(const QString &endpoint, const QJsonDocument &body)
{ sendRequest(QNetworkAccessManager::PutOperation, endpoint, {}, body.toJson(QJsonDocument::Compact)); }

void ApiClient::del(const QString &endpoint)
{ sendRequest(QNetworkAccessManager::DeleteOperation, endpoint, {}, {}); }

void ApiClient::post(const QString &endpoint, const QString &json)
{ sendRequest(QNetworkAccessManager::PostOperation, endpoint, {}, json.toUtf8()); }

void ApiClient::put(const QString &endpoint, const QString &json)
{ sendRequest(QNetworkAccessManager::PutOperation, endpoint, {}, json.toUtf8()); }

void ApiClient::loadToken()
{
    // Example implementation
    qDebug() << "Token loaded (stub)";
}
