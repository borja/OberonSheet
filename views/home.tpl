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
    <nav>
        <ul>
            <li><a href="">Enlace de Menu</a></li>
            <li><a href="">Muestrate desde arriba, Menu</a></li>
        </ul>
    </nav>
    <!-- main -->
<section>
    <h1>Characters</h1>
    <article>
        <!-- Database-->
        %for character in characters:
        <h2>{{character['name']}}</h1>
        <ul>
            %for key in character:
                %if key != 'name':
                    <li><b>{{key.title()}}:</b> {{character[key].title()}}</li>
                %end
            %end
        </ul> 
        %end
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

    $('article').click( function(){
        if ($('nav').attr("class") == "showing")
            $('nav').removeAttr("class");
    });
</script>
</body>
</html>