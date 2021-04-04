#include "selectionprint.h"
#include <QPainter>
#include <QPrintDialog>
#include <QPixmap>
#include <QImage>
#include <QDebug>
#include <QAbstractTextDocumentLayout>

SelectionPrint::SelectionPrint(QObject *parent)
    : QObject(parent)
{

    QString fileName(":/dnd/ui/res/invoicestyle.txt");

    QFile file(fileName);
    if(!file.open(QIODevice::ReadOnly)) {
        qDebug()<<"filenot opened"<<endl;
    }
    else
    {
        qDebug()<<"file opened"<<endl;
        m_invoiceStyle = file.readAll();
    }
    file.close();
}

void SelectionPrint::print(QVariant data)
{
    QImage img = qvariant_cast<QImage>(data);
    QPrinter printer(QPrinter::HighResolution); //create your QPrinter (don't need to be high resolution, anyway)
    printer.setPageSize(QPrinter::A4);
    printer.setOrientation(QPrinter::Portrait);
    printer.setPageMargins (15,15,15,15,QPrinter::Millimeter);
    printer.setFullPage(false);
    printer.setOutputFileName("output.pdf");
    printer.setOutputFormat(QPrinter::NativeFormat); //you can use native format of system usin QPrinter::NativeFormat
    //QPrintDialog dialog(&printer);
    //dialog.setWindowTitle("Print Document");
    QPainter painter(&printer);
    painter.drawImage(QPoint(0,0),img);
    painter.end();

}

void SelectionPrint::printHTML(QString htmlContent)
{

    QTextDocument *document = new QTextDocument();
    document->setHtml(m_invoiceStyle + htmlContent);

    QPrinter printer(QPrinter::HighResolution);
    printer.setPageSize(QPrinter::A4);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("filename.pdf");
    QPainter painter( &printer );
    QFont font = QFont("Times", 10, QFont::Normal);
    painter.setFont(font);
    document->documentLayout()->setPaintDevice(&printer);
    document->setPageSize(printer.pageRect().size());
    QFont myfont("Times", 10, QFont::Normal);
    document->setDefaultFont(myfont);
    QSizeF pageSize = printer.pageRect().size();
    const double tm = mmToPixels(printer, 12);
    const qreal footerHeight = painter.fontMetrics().height();
    const QRectF textRect(tm, tm, pageSize.width() - 2 * tm, pageSize.height() - 2 * tm - footerHeight);
    document->setPageSize(textRect.size());
    const int pageCount = document->pageCount();

    bool firstPage = true;
    for (int pageIndex = 0; pageIndex < pageCount; ++pageIndex) {

        if (!firstPage)
            printer.newPage();

        paintPage(pageIndex, pageCount, &painter, document, textRect, footerHeight );
        firstPage = false;
    }
}

double SelectionPrint::mmToPixels(QPrinter& printer, int mm)
{
    return mm * 0.039370147 * printer.resolution();
}

void SelectionPrint::paintPage(int pageNumber, int pageCount,
                               QPainter* painter, QTextDocument* doc,
                               const QRectF& textRect, qreal footerHeight)
{


    painter->save();
    // textPageRect is the rectangle in the coordinate system of the QTextDocument, in pixels,
    // and starting at (0,0) for the first page. Second page is at y=doc->pageSize().height().
    const QRectF textPageRect(0, pageNumber * doc->pageSize().height(), doc->pageSize().width(), doc->pageSize().height());
    // Clip the drawing so that the text of the other pages doesn't appear in the margins
    painter->setClipRect(textRect);
    // Translate so that 0,0 is now the page corner
    painter->translate(0, -textPageRect.top());
    // Translate so that 0,0 is the text rect corner
    painter->translate(textRect.left(), textRect.top());
    doc->drawContents(painter);
    painter->restore();
    QRectF footerRect = textRect;
    footerRect.setTop(textRect.bottom());
    footerRect.setHeight(footerHeight);
    painter->drawText(footerRect, Qt::AlignVCenter | Qt::AlignRight, QObject::tr("Page %1 of %2").arg(pageNumber+1).arg(pageCount));
}


QObject *SelectionPrint::createInstance(QQmlEngine *engine, QJSEngine *scriptEngine)
{
    Q_UNUSED(engine);
    Q_UNUSED(scriptEngine);
    static SelectionPrint *m_instance = new SelectionPrint();

    return m_instance;
}
