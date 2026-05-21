package test.org.fugerit.java.demo.venussamplepdffopxslt;

import org.apache.fop.apps.FOUserAgent;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopFactory;
import org.junit.jupiter.api.Test;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Result;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.sax.SAXResult;

@Slf4j
class TestFopTableWithRadius {

    @Test
    void generateTableWithRadius() throws Exception {
        // Input FO file and output PDF file
        File foFile = new File("src/test/resources/fo-sample/table-with-radius.fo");
        File pdfFile = new File("target/table-with-radius.pdf");

        log.info("Processing FO file: {}", foFile.getAbsolutePath());
        log.info("Output PDF file: {}", pdfFile.getAbsolutePath());

        // Ensure target directory exists
        if (pdfFile.getParentFile() != null) {
            boolean dirCreated = pdfFile.getParentFile().mkdirs();
            log.debug("Target directory created: {}", dirCreated);
        }

        try (InputStream foInputStream = new FileInputStream(foFile);
             OutputStream pdfOutputStream = new FileOutputStream(pdfFile)) {

            // Create FOP factory with default configuration
            FopFactory fopFactory = FopFactory.newInstance(new File(".").toURI());
            FOUserAgent foUserAgent = fopFactory.newFOUserAgent();

            // Create Fop instance
            Fop fop = fopFactory.newFop("application/pdf", foUserAgent, pdfOutputStream);

            // Set up the transformer
            TransformerFactory transformerFactory = TransformerFactory.newInstance();
            Transformer transformer = transformerFactory.newTransformer();

            // Set up the source and result
            Source foSource = new StreamSource(foInputStream);
            Result res = new SAXResult(fop.getDefaultHandler());

            // Transform the FO file to PDF
            transformer.transform(foSource, res);

            log.info("PDF generated successfully: {}", pdfFile.getAbsolutePath());
        }
    }

}
