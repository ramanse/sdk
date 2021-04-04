#ifndef SELECTIONPRINT_H
#define SELECTIONPRINT_H

#include <QObject>
#include <QVariant>
#include <QQmlEngine>
#include <QJSEngine>
#include <QPrinter>
#include <QTextDocument>

class SelectionPrint : public QObject
{
    Q_OBJECT

public:
    static QObject* createInstance(QQmlEngine *engine,  QJSEngine *scriptEngine);
    Q_INVOKABLE void print(QVariant data);
    Q_INVOKABLE void printHTML(QString htmlContent);
private:
    explicit  SelectionPrint(QObject *parent = nullptr);
    double mmToPixels(QPrinter& printer, int mm);
    void paintPage(int pageNumber, int pageCount,
                   QPainter* painter, QTextDocument* doc,
                   const QRectF& textRect, qreal footerHeight);
    QString m_invoiceStyle;
};

#endif // SELECTIONPRINT_H
