#ifndef APIENDPOINTS_H
#define APIENDPOINTS_H

#include <QString>

struct ApiEndpoints {
    static inline const QString BASE_URL = "https://api.lumin.example.com";

    static inline const QString AUTH_LOGIN = "/api/auth/login";
    static inline const QString AUTH_VERIFY = "/api/auth/verify-login";
    static inline const QString AUTH_REGISTER = "/api/auth/register";
    static inline const QString AUTH_FORGOT = "/api/auth/forgot-password";

    static inline const QString ADMIN_DASHBOARD = "/api/admin/dashboard";
    static inline const QString INSTRUCTOR_DASHBOARD = "/api/instructor/dashboard";

    static inline const QString INSTRUCTORS = "/api/admin/instructors";

    static QString instructorDetail(const QString& id)
    {
        return QString("/api/admin/instructors/%1").arg(id);
    }
};

#endif // APIENDPOINTS_H
