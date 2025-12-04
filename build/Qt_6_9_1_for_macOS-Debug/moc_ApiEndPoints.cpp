/****************************************************************************
** Meta object code from reading C++ file 'ApiEndPoints.h'
**
** Created by: The Qt Meta Object Compiler version 69 (Qt 6.9.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../ApiEndPoints.h"
#include <QtCore/qmetatype.h>

#include <QtCore/qtmochelpers.h>

#include <memory>


#include <QtCore/qxptype_traits.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'ApiEndPoints.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 69
#error "This file was generated using the moc from 6.9.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {
struct qt_meta_tag_ZN12ApiEndpointsE_t {};
} // unnamed namespace

template <> constexpr inline auto ApiEndpoints::qt_create_metaobjectdata<qt_meta_tag_ZN12ApiEndpointsE_t>()
{
    namespace QMC = QtMocConstants;
    QtMocHelpers::StringRefStorage qt_stringData {
        "ApiEndpoints",
        "baseUrl",
        "login",
        "verifyLogin",
        "registerInstructor",
        "forgotPassword",
        "resetPassword",
        "profile",
        "changePassword",
        "profileImage",
        "removeProfileImage",
        "refresh",
        "notifications",
        "readAllNotifications"
    };

    QtMocHelpers::UintData qt_methods {
    };
    QtMocHelpers::UintData qt_properties {
        // property 'baseUrl'
        QtMocHelpers::PropertyData<QString>(1, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'login'
        QtMocHelpers::PropertyData<QString>(2, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'verifyLogin'
        QtMocHelpers::PropertyData<QString>(3, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'registerInstructor'
        QtMocHelpers::PropertyData<QString>(4, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'forgotPassword'
        QtMocHelpers::PropertyData<QString>(5, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'resetPassword'
        QtMocHelpers::PropertyData<QString>(6, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'profile'
        QtMocHelpers::PropertyData<QString>(7, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'changePassword'
        QtMocHelpers::PropertyData<QString>(8, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'profileImage'
        QtMocHelpers::PropertyData<QString>(9, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'removeProfileImage'
        QtMocHelpers::PropertyData<QString>(10, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'refresh'
        QtMocHelpers::PropertyData<QString>(11, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'notifications'
        QtMocHelpers::PropertyData<QString>(12, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
        // property 'readAllNotifications'
        QtMocHelpers::PropertyData<QString>(13, QMetaType::QString, QMC::DefaultPropertyFlags | QMC::Constant),
    };
    QtMocHelpers::UintData qt_enums {
    };
    return QtMocHelpers::metaObjectData<ApiEndpoints, qt_meta_tag_ZN12ApiEndpointsE_t>(QMC::MetaObjectFlag{}, qt_stringData,
            qt_methods, qt_properties, qt_enums);
}
Q_CONSTINIT const QMetaObject ApiEndpoints::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN12ApiEndpointsE_t>.stringdata,
    qt_staticMetaObjectStaticContent<qt_meta_tag_ZN12ApiEndpointsE_t>.data,
    qt_static_metacall,
    nullptr,
    qt_staticMetaObjectRelocatingContent<qt_meta_tag_ZN12ApiEndpointsE_t>.metaTypes,
    nullptr
} };

void ApiEndpoints::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    auto *_t = static_cast<ApiEndpoints *>(_o);
    if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast<QString*>(_v) = _t->baseUrl(); break;
        case 1: *reinterpret_cast<QString*>(_v) = _t->login(); break;
        case 2: *reinterpret_cast<QString*>(_v) = _t->verifyLogin(); break;
        case 3: *reinterpret_cast<QString*>(_v) = _t->registerInstructor(); break;
        case 4: *reinterpret_cast<QString*>(_v) = _t->forgotPassword(); break;
        case 5: *reinterpret_cast<QString*>(_v) = _t->resetPassword(); break;
        case 6: *reinterpret_cast<QString*>(_v) = _t->profile(); break;
        case 7: *reinterpret_cast<QString*>(_v) = _t->changePassword(); break;
        case 8: *reinterpret_cast<QString*>(_v) = _t->profileImage(); break;
        case 9: *reinterpret_cast<QString*>(_v) = _t->removeProfileImage(); break;
        case 10: *reinterpret_cast<QString*>(_v) = _t->refresh(); break;
        case 11: *reinterpret_cast<QString*>(_v) = _t->notifications(); break;
        case 12: *reinterpret_cast<QString*>(_v) = _t->readAllNotifications(); break;
        default: break;
        }
    }
}

const QMetaObject *ApiEndpoints::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ApiEndpoints::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_staticMetaObjectStaticContent<qt_meta_tag_ZN12ApiEndpointsE_t>.strings))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ApiEndpoints::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::BindableProperty
            || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    }
    return _id;
}
QT_WARNING_POP
