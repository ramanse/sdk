#include "displaysettings.h"
#include <QDomDocument>
#include <QDebug>

DisplaySettings::DisplaySettings(QObject *parent) : QObject(parent)
{
}

int DisplaySettings::readXML()
{
    QDomDocument xmlBOM;
    QFile xmlFile(":/sdk/assets/config/DeviceDisplayInfo.xml");
    if (!xmlFile.open(QIODevice::ReadOnly ))
    {
        qCritical() << "Error while loading file" << endl;
        return 1;
    }
    xmlBOM.setContent(&xmlFile);

    QDomElement root=xmlBOM.documentElement();

    QDomElement device=root.firstChild().toElement();

    while(!device.isNull())
    {
        if (device.tagName()=="device")
        {
            DisplayInfo *info= new DisplayInfo();
            // Read and display the component ID
            info->setDeviceName(device.attribute("name",""));
            info->setWidth(device.attribute("width","720").toDouble());
            info->setHeight(device.attribute("height","1280").toDouble());
            info->setSize(device.attribute("size","5.5").toDouble());
            info->setDpi(device.attribute("dpi","5.5").toDouble());
            QStringList viewPort = device.attribute("viewport","375x667").split("x");
            info->setVWidth(viewPort.at(0).toDouble());
            info->setVHeight(viewPort.at(1).toDouble());
            m_deviceList.append(QVariant::fromValue(info));
        }
        // Next device
        device = device.nextSibling().toElement();
    }

    xmlFile.close();

}

QString DisplayInfo::deviceName() const
{
    return m_deviceName;
}

void DisplayInfo::setDeviceName(const QString &deviceName)
{
    if (deviceName != m_deviceName) {
        m_deviceName = deviceName;
        emit deviceNameChanged();
    }
}

qreal DisplayInfo::dpi() const
{
    return m_dpi;
}

void DisplayInfo::setDpi(const qreal &dpi)
{
    if (dpi != m_dpi) {
        m_dpi = dpi;
        dpiChanged();
    }
}

qreal DisplayInfo::vWidth() const
{
    return m_vWidth;
}

void DisplayInfo::setVWidth(const qreal &vWidth)
{
    m_vWidth = vWidth;
}

qreal DisplayInfo::vHeight() const
{
    return m_vHeight;
}

void DisplayInfo::setVHeight(const qreal &vHeight)
{
    m_vHeight = vHeight;
}

void DisplaySettings::processDisplayConfig()
{
    readXML();

}

qreal DisplayInfo::width() const
{
    return m_width;
}

void DisplayInfo::setWidth(const qreal &width)
{
    if (width != m_width) {
        m_width = width;
        emit widthChanged();
    }
}

qreal DisplayInfo::height() const
{
    return m_height;
}

void DisplayInfo::setHeight(const qreal &height)
{
    if (height != m_height) {
        m_height = height;
        emit heightChanged();
    }
}

qreal DisplayInfo::size() const
{
    return m_size;
}

void DisplayInfo::setSize(const qreal &size)
{
    if (size != m_size) {
        m_size = size;
        emit sizeChanged();
    }
}
