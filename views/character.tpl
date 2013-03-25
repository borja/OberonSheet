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
        <h1>{{character['information']['name']}}</h1>
        <ul>
            %for key in character:
            <li><b>{{ key.title() }}</b>
                <ul>
                    %for item in character[key]:
                    %if item != 'name' :
                    <li><b>{{ item.title() }}</b>: {{ character[key][item].title() }}</li>
                    %end
                    %end
                </ul>
            </li>
            %end
        </ul> 
    </article>
</section>
%include scripts_template
</body>
</html>