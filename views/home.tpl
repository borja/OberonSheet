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
            <a href="/new_character"><h2>New Character</h2></a>
        </article>
    <footer></footer>
</section>
%include scripts_template
</body>
</html>