<!DOCTYPE html>
<html lang="en">
<head><meta charset="ISO-8859-15" />
<title>Oberon -- Character sheet</title>
<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<link rel="stylesheet" href="/static/main.css" type="text/css" />
<script src="/static/jquery.js" ></script>

</head>
<body>
    <!-- menu -->
    %include header_template
    <!-- main -->
<section>
    <h1>Characters</h1>
        <!-- DB-->
        %for character in characters:
        <article class="main">
            <h2><a href="/character/{{character['_id']}}">{{character['name']}}</a></h1>
            <aside>Edit</aside>
        </article>
        %end
        <!-- End of DB-->
        <article class="main">
            <a href=""><h2>New Character</h2></a>
            <!-- UNDER CONSTRUCTION-->
            <aside>Under construction...</aside>
            <!-- UNDER CONSTRUCTION-->
        </article>
    <footer></footer>
</section>

<script>
    $('nav').click( function() {
        if ($('nav').attr("class") == undefined)
            $('nav').attr("class", "showing");
        else
            $('nav').removeAttr("class");
    });

    $('section').click( function(){
        if ($('nav').attr("class") == "showing")
            $('nav').removeAttr("class");
    });
</script>
</body>
</html>