%include header_template
<section class="container"><div class="row">
    <article class="char_info">
        <h1>{{character['name']}}</h1>
        <ul>
            %for key in character:
            %if key != 'name' :
            <li><b>{{ key.title() }}</b>
                <ul>
                    %for item in character[key]:
                    <li><b>{{ item.title() }}</b>: {{ character[key][item].title() }}</li>
                    %end
                </ul>
            </li>
            %end
            %end
        </ul> 
    </article>
</div></section>
%include footer_template