// #ifndef APICLIENT_H
// #define APICLIENT_H

// #include <QObject>
// #include <QNetworkAccessManager>
// #include <QUrlQuery>
// #include <QJsonDocument>

// class ApiClient : public QObject
// {
//     Q_OBJECT
// public:
//     static ApiClient* instance();

//     void sendRequest(QNetworkAccessManager::Operation op, const QString &endpoint,
//                      const QUrlQuery &query = {}, const QByteArray &payload = {});
//     void get(const QString &endpoint, const QUrlQuery &query = {});
//     void post(const QString &endpoint, const QJsonDocument &body);
//     void put(const QString &endpoint, const QJsonDocument &body);
//     void del(const QString &endpoint);
//     void post(const QString &endpoint, const QString &json);
//     void put(const QString &endpoint, const QString &json);

//     void loadToken(); // required by main.cpp

// signals:
//     void response(const QJsonDocument &doc, bool success, const QString &message, const QString &code);

// private:
//     explicit ApiClient(QObject *parent = nullptr);
//     QNetworkAccessManager m_nam;
// };

// #endif // APICLIENT_H
#ifndef APICLIENT_H
#define APICLIENT_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QSettings>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJSValue>
#include <QVariant>
#include <QJSEngine>

class ApiClient : public QObject
{
    Q_OBJECT

public:
    static ApiClient *instance();

    Q_INVOKABLE void get(const QString &url, QJSValue callback);
    Q_INVOKABLE void post(const QString &url, const QJsonObject &data, QJSValue callback);
    Q_INVOKABLE void put(const QString &url, const QJsonObject &data, QJSValue callback);
    Q_INVOKABLE void deleteMethod(const QString &url, QJSValue callback);

    void loadToken();
    void clearToken();

signals:
    void errorOccurred(const QString &error);

private:
    explicit ApiClient(QObject *parent = nullptr);
    static ApiClient *m_instance;

    QNetworkAccessManager *m_manager;
    QString m_token;

    void sendRequest(const QNetworkRequest &request, const QByteArray &data, QNetworkAccessManager::Operation op, QJSValue callback);
    QJsonObject handleResponse(QNetworkReply *reply);
    void attachToken(QNetworkRequest &request);
};

#endif // APICLIENT_H
