#ifndef DISPLAYSETTINGS_H
#define DISPLAYSETTINGS_H

#include <QObject>
#include <QtXml>
#include <QFile>
#include <QVariantList>

using namespace std;
class DisplayInfo : public QObject {
    Q_OBJECT
    Q_PROPERTY(QString deviceName READ deviceName NOTIFY deviceNameChanged)
    Q_PROPERTY(qreal width READ width NOTIFY widthChanged)
    Q_PROPERTY(qreal height READ height NOTIFY heightChanged)
    Q_PROPERTY(qreal size READ size NOTIFY sizeChanged)
    Q_PROPERTY(qreal dpi READ dpi NOTIFY dpiChanged)
    Q_PROPERTY(qreal vWidth READ vWidth NOTIFY vWidthChanged)
    Q_PROPERTY(qreal vHeight READ vHeight NOTIFY vHeightChanged)

public:
    qreal size() const;
    void setSize(const qreal &size);

    qreal height() const;
    void setHeight(const qreal &height);

    qreal width() const;
    void setWidth(const qreal &width);

    QString deviceName() const;
    void setDeviceName(const QString &deviceName);

    qreal dpi() const;
    void setDpi(const qreal &dpi);

    qreal vWidth() const;
    void setVWidth(const qreal &vWidth);

    qreal vHeight() const;
    void setVHeight(const qreal &vHeight);

signals:
    void deviceNameChanged();
    void widthChanged();
    void heightChanged();
    void sizeChanged();
    void dpiChanged();
    void vWidthChanged();
    void vHeightChanged();

private:
    QString m_deviceName;
    qreal m_width;
    qreal m_height;
    qreal m_size;
    qreal m_dpi;
    qreal m_vWidth;
    qreal m_vHeight;
};

class DisplaySettings : public QObject
{
    Q_OBJECT
public:
    explicit DisplaySettings(QObject *parent = nullptr);

    enum Device {
        iPhone_6_7_8,
        iPhone_6_7_8_Plus,
        iPhone_X,
        GalaxyS_8_9,
        GalaxyS_8_9_Plus,
        GalaxyS_6_7,
        Galaxy_Note_8,
        GalaxyJ_7,
        HuaweiP_8_9,
        HuaweiP_10,
        HuaweiP_20,
        Moto_Z_Z2,
        Moto_Z_Z2_P,
        lay,
        Moto_E4,
        Moto_DROID,
        Moto_G5,
        Redmi_Note_5,
        Redmi_Note_4_3,
        Redmi_4,
        Pixel_2_3_XL,
        Pixel_2,
        Pixel_3,
        Nexus_6P,
        Nexus_5,
        LGK_10_20,
        LG_Artiso_Stylo,
        LG_V20,
        LGK_7,
        ZTE_MAVEN,
        ZTE_MAX_PRO,
        OPPO_A37,
        VIVO_SONY
    };
    void processDisplayConfig();
    QVariantList getDisplaySettings() {
        return m_deviceList;
    }

signals:

public slots:
private:
    int readXML();
    QVariantList m_deviceList;
};

#endif // DISPLAYSETTINGS_H
