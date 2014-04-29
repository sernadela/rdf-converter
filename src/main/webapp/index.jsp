<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="author" content="sernadela at ua.pt">
        <link href="css/bootstrap.css" rel="stylesheet" >
        <link href="css/cover.css" rel="stylesheet">
        <title>RDF Converter</title>
    </head>
    <body>
        <div class="site-wrapper">

            <div class="site-wrapper-inner">

                <div class="cover-container">

                    <div class="masthead clearfix">
                        <div class="inner">
                            <h3 class="masthead-brand">RDF Converter</h3>
                            <ul class="nav masthead-nav">
                                <li class="active"><a href="#">Home</a></li>
                                <li><a href="mailto:sernadela@ua.pt?subject=RDFConverter">Contact</a></li>
                            </ul>
                        </div>
                    </div>

                    <div class="inner cover">
                        <h1 class="cover-heading">Paste the code here. <a id="sample" class="lead">Try sample</a>.</h1>
                        <p><textarea id="textarea" class="form-control" rows="10"></textarea></p>
                        <p>
                        <div class="row">
                            <div class="col-md-6">FROM
                                <select class="form-control" id="from">
                                    <option>NQUADS</option>
                                </select>
                            </div>
                            <div class="col-md-6">TO
                                <select class="form-control" id="to">
                                    <option>TRIG</option>
                                </select>
                            </div>
                        </div>

                        </p>
                        <p class="lead">
                            <a href="#" class="btn btn-lg btn-default" id="convert" data-toggle="modal" data-target="#myModal">Convert!</a>
                        </p>
                    </div>

                    <div class="mastfoot">
                        <div class="inner">
                            <p><iframe src="http://ghbtns.com/github-btn.html?user=sernadela&type=follow&count=true"
                                       allowtransparency="true" frameborder="0" scrolling="0" width="160" height="20"></iframe>
                                <iframe src="http://ghbtns.com/github-btn.html?user=sernadela&repo=rdf-converter&type=watch&count=true"
                                        allowtransparency="true" frameborder="0" scrolling="0" width="75" height="20"></iframe>
                                <iframe src="http://ghbtns.com/github-btn.html?user=sernadela&repo=rdf-converter&type=fork&count=true"
                                        allowtransparency="true" frameborder="0" scrolling="0" width="75" height="20"></iframe>
                            </p>
                            <p>Development project of <a href="http://bioinformatics.ua.pt">bioinformatics.ua.pt</a>, by <a href="https://github.com/sernadela">@sernadela</a>.</p>
                        </div>
                    </div>

                </div>

            </div>

        </div>

        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">Result</h4>
                    </div>
                    <div class="modal-body">
                        <textarea id="output" class="form-control" rows="30" readonly></textarea>
                    </div>
                    <div class="modal-footer">
                        <a id="download" type="button" class="btn btn-primary" >Download</a>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
        <script src="js/bootstrap.js"></script>
        <script type="text/javascript">

            $("#convert").click(function() {
                var content = $("#textarea").val();
                $.post("./service/", content, postCallback);
                //$.post("./service/url/","http://localhost:8080/coeus/nanopub/HGNC_BRAF_Nanopub", postTrigCallback);
            });

            $("#sample").click(function() {
                $("#textarea").val(example());
            });

            $(document).ready(function() {

            });

            function postTrigCallback(data, status) {
                //$("#output").html(data);
                console.log(data);
                console.log(status);

                //window.location.href = url;
                //document.write(r);
            }

            function postCallback(data, status) {
                $("#output").html(data);
                var contentType = 'application/trig';
                //contentType = 'text/plain';
                var blob = new Blob([data], {'type': contentType});
                var url = window.URL.createObjectURL(blob);
                var name = 'converter.trig';
                var download = document.getElementById("download");
                download.setAttribute("href", url);
                download.setAttribute("download", name);
            }

            function example() {
                return '<http://www.example.org/pubs#nanopubEx> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#Nanopublication> <http://www.example.org/pubs#nanopubEx> .'
                        + '<http://www.example.org/pubs#nanopubEx> <http://www.nanopub.org/nschema#hasAssertion> <http://www.example.org/pubs#assertion> <http://www.example.org/pubs#nanopubEx> .'
                        + '<http://www.example.org/pubs#nanopubEx> <http://www.nanopub.org/nschema#hasProvenance> <http://www.example.org/pubs#provenance> <http://www.example.org/pubs#nanopubEx> .'
                        + '<http://www.example.org/pubs#nanopubEx> <http://www.nanopub.org/nschema#hasPublicationInfo> <http://www.example.org/pubs#pubInfo> <http://www.example.org/pubs#nanopubEx> .'
                        + '<http://www.example.org/pubs#trastuzumab> <http://www.example.org/pubs#is-indicated-for> <http://www.example.org/pubs#breast-cancer> <http://www.example.org/pubs#assertion> .'
                        + '<http://www.example.org/pubs#assertion> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#Assertion> <http://www.example.org/pubs#assertion> .'
                        + '<http://www.example.org/pubs#assertion> <http://www.w3.org/ns/prov#generatedAtTime> "2012-02-03T14:38:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime> <http://www.example.org/pubs#provenance> .'
                        + '<http://www.example.org/pubs#assertion> <http://www.w3.org/ns/prov#wasDerivedFrom> <http://www.example.org/pubs#experiment> <http://www.example.org/pubs#provenance> .'
                        + '<http://www.example.org/pubs#assertion> <http://www.w3.org/ns/prov#wasAttributedTo> <http://www.example.org/pubs#experimentScientist> <http://www.example.org/pubs#provenance> .'
                        + '<http://www.example.org/pubs#provenance> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#Provenance> <http://www.example.org/pubs#provenance> .'
                        + '<http://www.example.org/pubs#nanopubEx> <http://www.w3.org/ns/prov#wasAttributedTo> <http://www.example.org/pubs#paul> <http://www.example.org/pubs#pubInfo> .'
                        + '<http://www.example.org/pubs#nanopubEx> <http://www.w3.org/ns/prov#generatedAtTime> "2012-10-26T12:45:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime> <http://www.example.org/pubs#pubInfo> .'
                        + '<http://www.example.org/pubs#pubInfo> <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.nanopub.org/nschema#PublicationInfo> <http://www.example.org/pubs#pubInfo> .';
            }

        </script>
    </body>
</html>
