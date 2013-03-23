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
     <article class="char_info">
        <h1>{{character['name']}}</h1>
        <ul>
        %for key in character:
            %if key not in ['name', '_id']:
            <li><b>{{ key }}:</b> {{character[key]}}</li>
            %end
        %end
        </ul> 
    </article>
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