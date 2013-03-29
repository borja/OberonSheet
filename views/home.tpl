%include header_template
<section class="container">
    <h1>Characters</h1>
    <div class="row">
        <!-- DB-->
        %for character in characters:
        <article class="span3 char_canvas">
            <h2><a href="/character/{{character['_id']}}">{{character['name']}}</a></h1>
            <a style="width: 207px" href="/character/{{character['_id']}}" class="thumbnail">
                <img data-src="holder.js/207x180" alt="207x180" style="width: 207px; height: 180px;" >
            </a>
            <aside><a href="/edit_character/{{character['_id']}}">Edit</a></aside>
        </article>
        <div class="span1"></div>
        %end
        <!-- End of DB-->
    </div>
    <a style="margin-top: 20px;" href="/new_character" class="btn btn-info">New Character</a>
</section>
%include footer_template