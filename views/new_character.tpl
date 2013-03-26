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
    <form>
        <h1>Your Character</h1>
        <label for="character-name">Name</label> <input type="text" name="name" placeholder="e.g. Alastor" required />
        <fieldset>
            <legend>Information:</legend>
            <label for="character-name">Gender:</label> <input type="text" name="gender" placeholder="e.g. Female" required />
            <label for="character-name">Class:</label> <input type="text" name="class" placeholder="e.g. Warrior" required />
        </fieldset>
        <input type="submit" value="Send" />
    </form>
</section>
<script>
    $('form').submit( function(event){
        event.preventDefault();
        //ENCODE FORM AS JSON
        var myJSON = new Object();
        myJSON['name'] = $("input[name='name']")[0].value;

        $("form > fieldset").each(function() {
            var section_name = $("legend", this).text();
            var section = new Object();
            $("input", this).each(function(){
                var attr_name = $(this).attr('name');
                var attr = $(this).val();
                section[attr_name] = attr;
            });
            myJSON[section_name] = section;
        });

        var tru_JSON = JSON.stringify(myJSON);
        var nulo = "";
        $.ajax({
            type: 'POST',
            url: 'new_character',
            data: tru_JSON,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response){
               console.log("success");
            }
        });
    })
</script>
%include scripts_template
</body>
</html>