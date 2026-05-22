// generated from template 'DocHelperTest.ftl' on 2025-11-02T22:05:57.74+01:00
package test.org.fugerit.java.demo.venussamplepdffopxslt;

import org.fugerit.java.demo.venussamplepdffopxslt.DocHelper;
import org.fugerit.java.demo.venussamplepdffopxslt.People;

import org.fugerit.java.doc.base.config.DocConfig;
import org.fugerit.java.doc.base.process.DocProcessContext;

import org.fugerit.java.doc.freemarker.html.FreeMarkerHtmlTypeHandlerUTF8;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import lombok.extern.slf4j.Slf4j;

/**
 * This is a basic example of Fugerit Venus Doc usage,
 * running this junit will :
 * - creates data to be used in document model
 * - renders the 'document.ftl' template
 * - print the result in markdown format
 *
 * For further documentation :
 * https://github.com/fugerit-org/fj-doc
 *
 * NOTE: This is a 'Hello World' style example, adapt it to your scenario, especially :
 * - change the doc handler and the output mode (here a ByteArrayOutputStream buffer is used)
 */
@Slf4j
class DocHelperTest {

    DocHelper docHelper = new DocHelper();

    @Test
    void testDocProcess() throws Exception {
        File pdfFileWithoutPageBreak = new File( "target/fop-xslt-sample-without-page-break.pdf" );
        File pdfFileWithPageBreak = new File( "target/fop-xslt-sample-with-page-break.pdf" );
        log.info( "pdfFileWithoutPageBreak {}, delete? {}", pdfFileWithoutPageBreak, pdfFileWithPageBreak.delete() );
        log.info( "pdfFileWithPageBreak {}, delete? {}", pdfFileWithPageBreak, pdfFileWithPageBreak.delete() );
        try (FileOutputStream fosNoPageBreak = new FileOutputStream( pdfFileWithoutPageBreak );
             FileOutputStream fosPageBreak = new FileOutputStream( pdfFileWithPageBreak ) ) {
            // create custom data for the fremarker template 'document.ftl'
            List<People> listPeople = new ArrayList<>();
            for ( int k=0; k<11; k++ ) {
                listPeople.add( new People("Luthien", "Tinuviel", "Queen") );
                listPeople.add( new People("Thorin", "Oakshield", "King") );
            }

            List<People> listPeopleEnd = Arrays.asList(
                    new People("Margherita", "Hack", "Astrophysicist"), new People("Alan", "Turing", "Mathematician"));

            String chainId = "document";
            // handler id
            String handlerId = DocConfig.TYPE_PDF;

            // output generation with no page break
            docHelper.getDocProcessConfig().fullProcess(chainId,
                    DocProcessContext.newContext("listPeople", listPeople)
                            .withAtt( "listPeopleEnd", listPeopleEnd ), handlerId, fosNoPageBreak);

            // output generation with page break
            docHelper.getDocProcessConfig().fullProcess(chainId,
                    DocProcessContext.newContext("listPeople", listPeople)
                            .withAtt( "listPeopleEnd", listPeopleEnd )
                            .withAtt( "enableXslt", Boolean.TRUE )  // to enable xslt processing on our template
                            .withAtt( "debugXslt", Boolean.TRUE ),  // if se to true will print the final xslt
                            handlerId, fosPageBreak);

            Assertions.assertNotEquals( 0, pdfFileWithoutPageBreak.length() );
            Assertions.assertNotEquals( 0, pdfFileWithPageBreak.length() );
        }
    }

    @Test
    void testDocProcessTableWithRadius() throws Exception {
        File pdfFileTableWithRadius = new File( "target/fop-xslt-sample-table-with-radius.pdf" );
        File htmlFileTableWithRadius = new File( "target/fop-xslt-sample-table-with-radius.html" );
        log.info( "pdfFileTableWithRadius {}, delete? {}", pdfFileTableWithRadius, pdfFileTableWithRadius.delete() );
        log.info( "htmlFileTableWithRadius {}, delete? {}", htmlFileTableWithRadius, htmlFileTableWithRadius.delete() );
        try (FileOutputStream fosTableWithRadius = new FileOutputStream( pdfFileTableWithRadius );
             FileOutputStream htmlTableWithRadius = new FileOutputStream( htmlFileTableWithRadius )) {

            // create custom data for the fremarker template 'document.ftl'
            List<People> listPeople = new ArrayList<>();
            listPeople.add( new People("Luthien", "Tinuviel", "Queen") );
            listPeople.add( new People("Thorin", "Oakshield", "King") );
            String chainId = "document-table-with-radius";
            // handler id
            String handlerId = DocConfig.TYPE_PDF;

            DocProcessContext context = DocProcessContext.newContext("listPeople", listPeople)
                    .withAtt( "docTitle", "Apache FOP XLST table with radius example" )
                    .withAtt( "listPeople", listPeople )
                    .withAtt( "enableXslt", Boolean.TRUE )  // to enable xslt processing on our template
                    .withAtt( "debugXslt", Boolean.TRUE ); // if se to true will print the final xslt

            // output generation table with radius
            docHelper.getDocProcessConfig().fullProcess(chainId, context, handlerId, fosTableWithRadius);

            docHelper.getDocProcessConfig().fullProcess(chainId, context, FreeMarkerHtmlTypeHandlerUTF8.HANDLER.getKey(), htmlTableWithRadius);

            Assertions.assertNotEquals( 0, pdfFileTableWithRadius.length() );
            Assertions.assertNotEquals( 0, htmlFileTableWithRadius.length() );
        }
    }

}
