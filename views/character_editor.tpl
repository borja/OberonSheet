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
<script src="/static/char_editor.js"></script>
<script>
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function isJSON(json){ //checks wether the parameter string is a valid JSON or not
    try {
        JSON.parse(JSON.stringify(json));
    } catch (e) {
        return -1;
    }
    return 1;
};

function isList(json){
    var str = JSON.stringify(json);
    if (str.substring(0,1) == '[')
        return 1;
    else
        return -1;
};

function isDict(json){
    var str = JSON.stringify(json);
    if (str.substring(0,1) == '{')
        return 1;
    else
        return -1;
};

function doInfo(json){
    var toReturn = '<br><label>' + json['name'].capitalize() + '</label>' + //LABEL
        '<' + json['tag'] + ' '; //OPEN TAG
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
    
    return toReturn;
};

function doNumber(json){
    var toReturn = '';
    //first, order the json just in case
    var myObj =
        json,
        keys = Object.keys(myObj),
        i, len = keys.length;
    keys.sort();

    for (i = 0; i < len; i++)
    {   toReturn += "<div style=\"margin-right: 5.5em; float: left;\">";
        k = keys[i];
        toReturn += '<h4>' + k.capitalize() + '</h4>';
        console.log(k + ':' + json[k]);
        for (z in json[k]){
            toReturn += '<label>' + json[k][z].capitalize() + '</label><input type="number" name="' + json[k][z] + '" />';
        }
        toReturn += "</div>";
    }
    return toReturn;
};

function loadForm(JSONObject){
    var add_html = '';
    if ( isJSON(JSONObject) == 1){
        for (section in JSONObject) {
            if ( typeof(JSONObject[section]) == "object" && isJSON(JSONObject[section]) == 1 ){ //is JSON
                add_html += '<fieldset><legend>'+section.capitalize()+'</legend>';
                if ( section == 'information' )
                    for (item in JSONObject[section])
                        add_html += doInfo(JSONObject[section][item]);
                else if ( section == 'attributes' )
                    add_html += doNumber(JSONObject[section]);
                add_html += '</fieldset>';
            }
            else if (section != 'name')
                add_html += '<br><label>' + section.capitalize() + '</label><input name="' + section + '" />';
        }
        $('form').append(add_html);
    }
    else
        $('form').append('<p>Error loading the form</p>');
};

$(document).ready(function() {

    if ($('#hidden').val() == 'new'){
        $.ajax({
        type: 'GET',
        url: '/get_template',
        data: 'name=HeroQuest',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        complete: function(response){
            loadForm(JSON.parse(response.responseText));
        }
        });
    }

});


</script>
</body>
</html>