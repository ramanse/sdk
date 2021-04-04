#include <QGuiApplication>
#include <QRect>
#include <QScreen>
#include <QDebug>
#include "dpihandling.h"
#if defined (Q_OS_MACOS)
#include "displaysettings.h"
#endif
#include <QKeyEvent>

DisplayHandler::DisplayHandler(QObject *parent) : QObject(parent){

    QRect rect = QGuiApplication::primaryScreen()->geometry();
    m_screenHeight = rect.height();
    m_screenWidth = rect.width();
    m_scaleFactor = QGuiApplication::primaryScreen()->physicalDotsPerInch() / 160;
    isDNDManager = qgetenv("DNDManager").toStdString() == "true";
    qCritical()<<"Android now "<< m_scaleFactor;
    qCritical()<<"Android now "<< 0.75 * m_scaleFactor;

#if defined (Q_OS_MACOS)

    DisplaySettings settings;
    settings.processDisplayConfig();
    m_displaySettings = settings.getDisplaySettings();
    if (!isDNDManager)
        changeDisplay(currentDisplayIndex);
#endif
    //qMin(m_screenHeight/refHeight, m_screenWidth/refWidth);
}

QObject *DisplayHandler::createInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static DisplayHandler *m_instance = new DisplayHandler();
    return m_instance;
}

qreal DisplayHandler::dp(qreal value)
{
    qreal pxToDp = value * 0.75;
    qreal returnValue = (QGuiApplication::primaryScreen()->physicalDotsPerInch()  / 160.) * pxToDp;

#if defined (Q_OS_MACOS)
    returnValue = (300 / 160) * pxToDp;
    if (isDNDManager) {
        returnValue = value;
    }
#endif
    return returnValue;
}

qreal DisplayHandler::sp(qreal value)
{
    qreal pxToDp = value;
    qreal returnValue = (QGuiApplication::primaryScreen()->physicalDotsPerInch()  / 160.) * pxToDp;

#if defined (Q_OS_MACOS)
    returnValue = (296 / 160) * pxToDp;
#endif
    return returnValue;
}

qreal DisplayHandler::dpForAsset(qreal value)
{
    qreal pxToDp = value;
    qreal returnValue = (QGuiApplication::primaryScreen()->physicalDotsPerInch()  / 640.) * pxToDp;

#if defined (Q_OS_MACOS)
    returnValue = (QGuiApplication::primaryScreen()->physicalDotsPerInch()  / 640.) * pxToDp;
     if (isDNDManager) {
         returnValue = 0.7 * value;
     }
#endif
    return returnValue;
}

void DisplayHandler::changeDisplay(int value)
{
#if defined (Q_OS_MACOS)
    currentDisplayIndex = value;
    auto display = m_displaySettings.at(currentDisplayIndex);
    QObject * obj = qvariant_cast<QObject *>(display);
    DisplayInfo *info = qobject_cast<DisplayInfo *>(obj);
    if (info != nullptr) {
        m_screenWidth = currentOrientation == 1? info->vHeight() : info->vWidth();
        m_screenHeight = currentOrientation == 1? info->vWidth() : info->vHeight();
        m_scaleFactor = info->dpi() / 160;
        emit screenWidthChanged();
        emit screenHeightChanged();
        emit scaleFactor();
    }
#endif
}

void DisplayHandler::changeDisplayOrientation(int value)
{
#if defined (Q_OS_MACOS)
    currentOrientation = value;
    auto display = m_displaySettings.at(currentDisplayIndex);
    QObject * obj = qvariant_cast<QObject *>(display);
    DisplayInfo *info = qobject_cast<DisplayInfo *>(obj);
    if (info != nullptr) {
        m_screenWidth = currentOrientation == 1? info->vHeight() : info->vWidth();
        m_screenHeight = currentOrientation == 1? info->vWidth() : info->vHeight();
        m_scaleFactor = info->dpi() / 160;
        qCritical()<< m_screenWidth <<m_screenHeight << m_scaleFactor;
        emit screenWidthChanged();
        emit screenHeightChanged();
        emit scaleFactor();
    }
#endif
}

QVariantList DisplayHandler::displaySettings() const
{
    return m_displaySettings;
}

bool DisplayHandler::eventFilter(QObject *obj, QEvent *event)
{
    if (event->type()==QEvent::KeyPress) {
        QKeyEvent* key = static_cast<QKeyEvent*>(event);
        if ( (key->key()==Qt::Key_D && key->modifiers() == Qt::SHIFT) ) {
            showDebugPanel();
        } else {
            return QObject::eventFilter(obj, event);
        }
        return true;
    } else {
        return QObject::eventFilter(obj, event);
    }
    return false;
}
