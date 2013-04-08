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

//SUBMIT FORM
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