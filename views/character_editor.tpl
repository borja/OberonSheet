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
        <!-- NEW CHARACTER -->
        <h1>New Character</h1>
        <input id="hidden_id" type="hidden" value="" />
        <input id="hidden" type="hidden" value="new" />
        <input style="font-size: 38.5px; line-height: 40px; height: 40px;" class="input-xlarge" type="text" name="name" placeholder="Name" required />
        <!-- LOAD FORM WITH AJAX -->
        %else:
        <!-- EDIT CHARACTER -->
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
<script src="/static/char_editor.js"></script>
<script>
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function doInfo(json){
    var toReturn = '';
    if (json['tag'] != 'h4'){
        toReturn += '<label>' + json['name'].capitalize() + '</label>'; //LABEL if tag != h4
        toReturn += '<' + json['tag'] + ' '; //OPEN TAG
        var hayValues = false;
        for (z in json)
            if (z != 'tag' && z != 'values')
                toReturn += z + '="' + json[z] + '" ';
            else if (z == 'values')
                hayValues = true;
        toReturn += '>';
        if (hayValues == true)
            for (value in json['values'])
                toReturn += '<option value="' + json['values'][value] + '">' + json['values'][value].capitalize() + '</option>';
        toReturn += '</' + json['tag'] + '>';    
    }else{
        toReturn += '<h4>' + json['name'].capitalize() + '</h4>';
    }
    toReturn += '<br>';
    return toReturn;
};

function loadForm(JSONObject){
    var add_html = '';
    var sections = JSONObject['order'];
    var template = JSONObject['template'];
    //builds tab navigator
    add_html += loadFormNav(sections);
    add_html += '<div id="myTabContent" class="tab-content">';
    for (var i in sections){
        var section = sections[i];
        add_html +=  '<fieldset id="' + section+ '" class="tab-pane fade';
        if (i == '0')
            add_html += ' active in">';
        else
            add_html += '">';
        var key_order = {};
        for (key in template[section]['fields']){
            var seq = template[section]['fields'][key]['seq'];
            key_order[seq] = key;
        }
        var h_counter = 0;
        for (key in key_order){
            if (template[section]['fields'][key_order[key]]['tag'] == 'h4'){
                //sub-sections separated by div, side to side. h_counter counts the number of sub-sections
                if ( h_counter > 0)
                    add_html += '</div>';
                add_html += '<div style="float:left; margin-right:5.5em;">';
                h_counter++;
            }
            
            add_html += doInfo(template[section]['fields'][key_order[key]]);
        }
        if (h_counter > 0)
            add_html += '</div>';
        add_html += '</fieldset>';
    }
    add_html += '</div>';
    $('form').append(add_html);
    //add buttons at the end
    $('form').append('<footer class="form-actions"><input type="submit" class="btn btn-primary" value="Submit"/><a href="/" id="cancel" class="btn">Cancel</a></footer>');
};

function loadFormNav(JSONObject){
    var add_html = '<ul class="nav nav-tabs">';
    var counter = 0;
    for (key in JSONObject){
        if (counter == 0)
            add_html += '<li class="active">';
        else
            add_html += '<li class="">';
        add_html += '<a href="#' + JSONObject[key] + '" data-toggle="tab">' + JSONObject[key].capitalize() + '</a></li>';
        counter++;
    }
    add_html += '</ul>';
    return add_html;
}

$(document).ready(function() {

    if ($('#hidden').val() == 'new'){
        $.ajax({
        type: 'GET',
        url: '/get_template',
        data: 'name=HeroQuest',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        complete: function(response){//load form builder
            loadForm(JSON.parse(response.responseText));
        }
        });

        $('#myTab a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
    }

});


</script>
</body>
</html>