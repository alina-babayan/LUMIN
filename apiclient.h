#ifndef APICLIENT_H
#define APICLIENT_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QUrlQuery>
#include <QJsonDocument>

class ApiClient : public QObject
{
    Q_OBJECT
public:
    static ApiClient* instance();

    void sendRequest(QNetworkAccessManager::Operation op, const QString &endpoint,
                     const QUrlQuery &query = {}, const QByteArray &payload = {});
    void get(const QString &endpoint, const QUrlQuery &query = {});
    void post(const QString &endpoint, const QJsonDocument &body);
    void put(const QString &endpoint, const QJsonDocument &body);
    void del(const QString &endpoint);
    void post(const QString &endpoint, const QString &json);
    void put(const QString &endpoint, const QString &json);

    void loadToken(); // required by main.cpp

signals:
    void response(const QJsonDocument &doc, bool success, const QString &message, const QString &code);

private:
    explicit ApiClient(QObject *parent = nullptr);
    QNetworkAccessManager m_nam;
};

#endif // APICLIENT_H
