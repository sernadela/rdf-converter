/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pt.ua.bioinformatics.converter;

import com.hp.hpl.jena.sparql.core.DatasetGraph;
import com.hp.hpl.jena.sparql.core.DatasetGraphFactory;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.HashMap;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.UriInfo;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Produces;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.riot.RDFFormat;

/**
 * REST Web Service
 *
 * @author Pedro Sernadela <sernadela at ua.pt>
 */
@Path("/")
public class ServiceResource {

    @Context
    private UriInfo context;

    /**
     * Creates a new instance of ServiceResource
     */
    public ServiceResource() {
    }

    /**
     * Retrieves representation of an instance of
     * pt.ua.rdf.converter.ServiceResource
     *
     * @return an instance of java.lang.String
     */
    @GET
    @Produces("text/plain")
    public String test() {
        return "It works!";
    }

    /**
     * PUT method for updating or creating an instance of ServiceResource
     *
     * @param content representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @POST
    //@Consumes("text/plain")
    public String convert(String content) {
        StringWriter sw = new StringWriter();
        DatasetGraph dg = DatasetGraphFactory.createMem();
        InputStream stream = new ByteArrayInputStream(content.getBytes());
        try {
            RDFDataMgr.read(dg, stream, Lang.NQUADS);

            RDFDataMgr.write(sw, dg, RDFFormat.TRIG);
        } catch (Exception e) {
            sw.write(e.getLocalizedMessage());
        }

        return sw.toString();
    }

    /**
     * PUT method for converting an instance of ServiceResource
     *
     * @param url representation for the resource
     * @return an HTTP response with content of the updated or created resource.
     */
    @Path("/url/")
    @POST
    //@Consumes("text/plain")
    //@Produces(MediaType.TEXT_PLAIN)
    public String convertURL(String url) {
        System.out.println(url);
        StringWriter sw = new StringWriter();
        DatasetGraph dg = DatasetGraphFactory.createMem();
        try {
            RDFDataMgr.read(dg, url, Lang.NQUADS);
            HashMap<String, String> prefixes = new HashMap<String, String>();
            prefixes.put("coeus", "http://bioinformatics.ua.pt/coeus/resource/");
            prefixes.put("dc", "http://purl.org/dc/elements/1.1/");
            prefixes.put("np", "http://www.nanopub.org/nschema#");
            prefixes.put("prov", "http://www.w3.org/ns/prov#");
            prefixes.put("xsd", "http://www.w3.org/2001/XMLSchema#");
            prefixes.put("rdfs", "http://www.w3.org/2000/01/rdf-schema#");
            prefixes.put("rdf", "http://www.w3.org/1999/02/22-rdf-syntax-ns#");
            prefixes.put("dcterms", "http://purl.org/dc/terms/");
            
            dg.getDefaultGraph().getPrefixMapping().setNsPrefixes(prefixes);
            RDFDataMgr.write(sw, dg, RDFFormat.TRIG);
        } catch (Exception e) {
            sw.write(e.getLocalizedMessage());
        }

        return sw.toString();
    }
}
