<!DOCTYPE html>
<html lang="en">
<head><meta charset="ISO-8859-15" />
<title>Oberon -- Character sheet</title>
<!--[if lt IE 9]><script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script><![endif]-->

<link rel="stylesheet" href="/static/main.css" type="text/css" />
<link rel="stylesheet" href="/static/bootstrap/css/bootstrap.min.css" media="screen" />
<link rel="stylesheet" href="/static/bootstrap/css/bootstrap-responsive.min.css" media="screen" />

</head>
<body>
    <!-- menu -->
    %include header_template
    <!-- main -->
<section class="container">
    <form>
        <h1>Your Character</h1>
        <label for="character-name">Name</label> <input type="text" name="name" placeholder="e.g. Alastor" required />
        <fieldset>
            <legend>Information:</legend>
            <label for="character-name">Gender:</label> <input type="text" name="gender" placeholder="e.g. Female" required />
            <label for="character-name">Class:</label> <input type="text" name="class" placeholder="e.g. Warrior" required />
        </fieldset>
        <div class="form-actions">
            <input type="submit" class="btn btn-primary" value="Submit" />
            <a href="/" class="btn">Cancel</a>
        </div>
    </form>
</section>
<script src="/static/jquery.js" ></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
    $(window).keydown(function(event){
        if(event.keyCode == 13) {
            event.preventDefault();
            return false;
        }
    });

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
            complete: function(response){
               if (response.responseText == "success"){
                    $('.btn-primary').addClass('btn-success');
                    $('.btn-primary').val('Success')
                    $('.btn', 'form-actions').attr('disabled', 'disabled');
                    $('.btn-primary').removeClass('btn-primary');
                }
                else{
                    $('.btn-primary').addClass('btn-danger');
                    $('.btn-danger').text("Error")
                    $('.btn-primary').removeClass('btn-primary');
                }
            }
        });

    })
</script>
</body>
</html>