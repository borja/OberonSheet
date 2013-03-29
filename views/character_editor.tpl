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
        %if character == '':
        <h1>New Character</h1>
        <input id="hidden_id" type="hidden" value="" />
        <input id="hidden" type="hidden" value="new" />
        <input style="font-size: 38.5px; line-height: 40px; height: 40px;" class="input-xlarge" type="text" name="name" placeholder="Name" required />
        <fieldset>
            <legend>Information</legend>
            <label for="character-gender">Gender:</label> <input type="text" name="gender" placeholder="e.g. Female" required />
            <label for="character-class">Class:</label> <input type="text" name="class" placeholder="e.g. Warrior" required />
        </fieldset>
        %else:
        <h1>Edit Character</h1>
        <input id="hidden_id" type="hidden" value="{{ character['_id'] }}" />
        <input id="hidden" type="hidden" value="edit" />
        <input style="font-size: 38.5px; line-height: 40px; height: 40px;" class="input-xlarge" type="text" name="name" placeholder="Name" value="{{character['name']}}" required />
        %for section in character:
            %if section not in ['_id', 'name']:
                <fieldset>
                <legend>Information</legend>
                %for item in character[section]:
                 <label for="character-{{ item.lower() }}">{{ item.capitalize() }}:</label> <input type="text" name="{{ item.lower() }}" placeholder=" {{ item.capitalize() }} " value="{{ character[section][item] }}" required />
                %end
                </fieldset>
            %end
        %end
        %end
        <footer class="form-actions">
            <input type="submit" class="btn btn-primary" value="Submit" />
            <a href="/" id="cancel" class="btn">Cancel</a>
        </footer>
    </form>
</section>
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="myModalLabel">No changes were made</h3>
  </div>
  <div class="modal-body">
    <p>You have to make some changes first.</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
<script src="/static/jquery.js" ></script>
<script src="/static/bootstrap/js/bootstrap.min.js"></script>
<script>
//Records the state of the form when the page loads (edit mode)
var original_form = new Object();
if ($('#hidden').val() == 'edit'){
     original_form['name'] = $("input[name='name']").val();
     original_form['_id'] = $('#hidden_id').val();
    $("form > fieldset").each(function() {
        var section_name = $("legend", this).text();
        var section = new Object();
        $("input", this).each(function(){
            var attr_name = $(this).attr('name');
            var attr = $(this).val();
            section[attr_name] = attr;
        });
        original_form[section_name] = section;
    });
}

//Blocks submit by pressing enter
$(window).keydown(function(event){
    if(event.keyCode == 13) {
        event.preventDefault();
        return false;
    }
});

//Establishes if there's been a change in the input field (edit mode)
$('input').focusout(function(){
    if ($('#hidden').val() == 'edit'){
        var input_name = $(this).attr('name');
        var parent = $(this).siblings('legend').text();
        if (original_form[parent][input_name] != $(this).val())
            $(this).addClass("changed");
    }
});


$('form').submit( function(event){
    event.preventDefault();
    //ENCODE FORM AS JSON
    var myJSON = new Object();
    var changedCount = 0;

    if ($('#hidden').val() == 'new') // New character
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
    else //Editing character
        $("form > fieldset").each(function() {
            var section_name = $("legend", this).text();
            var section = new Object();
            $("input", this).each(function(){
                if ($(this).hasClass('changed')){
                    changedCount++;
                    var attr_name = $(this).attr('name');
                    var attr = $(this).val();
                    section[attr_name] = attr;
                }
            });
            myJSON[section_name] = section;
        });
    if (changedCount == 0 && $('#hidden').val() != 'new'){
        $('#myModal').modal('show')
        return; //no changes were made to the form
    }

    var url = '';
    
    if ($('#hidden').val() == 'new'){
        myJSON['name'] = $("input[name='name']").val();
        url = '/new_character';
    }
    else{
        url = '/edit_character';
        myJSON['_id'] = $('#hidden_id').val();
        if ($("input[name='name']").hasClass('changed'))
             myJSON['name'] = $("input[name='name']").val();
    }

    var tru_JSON = JSON.stringify(myJSON);

    $.ajax({
        type: 'POST',
        url: url,
        data: tru_JSON,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        complete: function(response){
           if (response.responseText == "success"){
                $('.btn-primary').addClass('btn-success');
                $('.btn-primary').val('Success')
                $('.btn-primary').attr('disabled', 'disabled');
                $('#cancel').text("Volver");
                $('.btn-primary').removeClass('btn-primary');
            }
            else{
                $('.btn-primary').addClass('btn-danger');
                $('.btn-danger').val("Error")
                $('.btn').attr('disabled', 'disabled');
                $('.btn-primary').removeClass('btn-primary');
            }
        }
    });

})
</script>
</body>
</html>