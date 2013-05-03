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
    %ordered = {}
        %for section in template:
          %if section not in ['_id', 'name']:
            %ordered[int(template[section]['seq'])] = section 
          %end
        %end

<section class="container">
    <form>
        <!-- EDIT CHARACTER -->
        <h1>Edit Character</h1>
        <input id="hidden_id" type="hidden" value="{{ character['_id'] }}" />
        <input id="hidden" type="hidden" value="edit" />
        <input style="font-size: 38.5px; line-height: 40px; height: 40px;" class="input-xlarge" type="text" name="name" placeholder="Name" value="{{character['name']}}" required />
        <ul class="nav nav-tabs">
        %for x in xrange (len(ordered)):
          %if x == 0:
            <li class="active">
          %else:
            <li class="">
          %end
          <a href="#{{ordered[x]}}" data-toggle="tab">{{ordered[x].title()}}</a></li>
        %end
        </ul>
        <div id="myTabContent" class="tab-content">
            %for x in xrange (len(ordered)):
                %if x == 0:
                    <fieldset id="{{ordered[x]}}" class="tab-pane fade active in">
                %else:
                <fieldset id="{{ordered[x]}}" class="tab-pane fade">
                %end

                %for item in sorted(template[ordered[x]]['fields'], key=lambda k:k['seq']):
                    <label>{{item['name'].title()}}</label>
                    <{{item['tag']}}
                    %select_values = []
                    %for attr in item:
                        %if attr not in ['tag', 'seq', 'values']:
                           {{attr}}="{{item[attr]}}"
                        %end
                    %end
                    >
                    %if item['tag'] == 'select':
                        %for val in item['values']:
                            <option value="{{val}}">{{val.title()}}</option>
                        %end
                    %end 
                    
                    </{{item['tag']}}>
                %end
                

</fieldset>
            %end
        </div>
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
</body>
</html>