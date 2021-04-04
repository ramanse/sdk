#ifndef DISPLAYHANDLER_H
#define DISPLAYHANDLER_H

#include <QObject>
#include <QQmlEngine>
#include <QJSEngine>

class DisplayHandler: public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal screenWidth READ screenWidth NOTIFY screenWidthChanged)
    Q_PROPERTY(qreal screenHeight READ screenHeight NOTIFY screenHeightChanged)
    Q_PROPERTY(qreal scaleFactor READ scaleFactor NOTIFY scaleFactorChanged)
    Q_PROPERTY(qreal fontFactor READ fontFactor NOTIFY fontFactorChanged)
    Q_PROPERTY(QVariantList displaySettings READ displaySettings NOTIFY displaySettingsChanged)

public:
    static QObject* createInstance(QQmlEngine *engine,  QJSEngine *scriptEngine);

    Q_INVOKABLE qreal dp(qreal value);
    Q_INVOKABLE qreal sp(qreal value);
    Q_INVOKABLE qreal dpForAsset(qreal value);
    Q_INVOKABLE void changeDisplay(int value);
    Q_INVOKABLE void changeDisplayOrientation(int value);
    Q_INVOKABLE void listenTo(QObject *object)
       {
           if (!object || qgetenv("DNDManager").toStdString() != "true")
               return;

           object->installEventFilter(this);
       }

    qreal scaleFactor() const
       { return m_scaleFactor; }

    qreal fontFactor() const
       { return m_fontFactor; }

    qreal screenWidth() const
       { return m_screenWidth; }

    qreal screenHeight() const
       { return m_screenHeight; }

    QVariantList displaySettings() const;

signals:
    void scaleFactorChanged();
    void fontFactorChanged();
    void screenWidthChanged();
    void screenHeightChanged();
    void showDebugPanel();
    void displaySettingsChanged();

protected:
    bool eventFilter(QObject* obj, QEvent* event);

private:
    explicit  DisplayHandler(QObject *parent = nullptr);

    qreal m_scaleFactor = 1.0;
    qreal m_fontFactor = 1.0;
    qreal m_screenWidth = 1.0;
    qreal m_screenHeight = 1.0;
    int currentDisplayIndex = 9;
    qint8 currentOrientation = 0;
    bool isDNDManager = false;
    QVariantList m_displaySettings;
};

#endif // DISPLAYHANDLER_H
