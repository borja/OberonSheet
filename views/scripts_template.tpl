<script>     
    $('nav').click( function(event) {
        if (event.target.tagName != 'A')
            if ($('nav').attr("class") == undefined)
                $('nav').attr("class", "showing");
            else            
                $('nav').removeAttr("class");
    });

    $('section').click( function(event){
        if ($('nav').attr("class") == "showing" && event.target.tagName != 'A')
            $('nav').removeAttr("class");
    });
</script>