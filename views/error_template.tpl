<!DOCTYPE html>
<html lang="en">
<head><meta charset="ISO-8859-15" />
<title>Oberon -- Character sheet -- ERROR</title>
<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<link rel="stylesheet" href="/static/main.css" type="text/css" />
<script src="/static/jquery.js" ></script>

</head>
<body>
    <!-- menu -->
    <nav>
        <ul>
            <li><a href="">Enlace de Menu</a></li>
            <li><a href="">Muestrate desde arriba, Menu</a></li>
        </ul>
    </nav>
    <!-- main article -->
    <article>
        <h1>ERROR</h1>
        <p>Ooops! Something went wrong...</p>
    </article>

<script>
    $('nav').click( function() {
        if ($('nav').attr("class") == undefined)
            $('nav').attr("class", "showing");
        else
            $('nav').removeAttr("class");
    });

    $('article').click( function(){
        if ($('nav').attr("class") == "showing")
            $('nav').removeAttr("class");
    });
</script>
</body>
</html>