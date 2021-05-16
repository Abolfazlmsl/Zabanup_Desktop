function rtfToPlain(str){

    //****************************************************** TAG
    var indx = str.indexOf('<')
    var indx2 = str.indexOf('>') + 1
    while(indx !== -1){
        str = str.replace(str.substring(indx , indx2) , "")

        indx = str.indexOf('<')
        indx2 = str.indexOf('>') + 1
    }
    //****************************************************** END TAG

    //****************************************************** Space
    indx = str.indexOf('&nbsp;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 6)) , " ")
        indx = str.indexOf('&nbsp;')
    }

    indx = str.indexOf('&#160;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 6)) , " ")
        indx = str.indexOf('&#160;')
    }
    //****************************************************** END Space

    //****************************************************** Quotation Mark "
    indx = str.indexOf('&quot;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 6)) , "\"")
        indx = str.indexOf('&quot;')
    }

    indx = str.indexOf('&#34;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\"")
        indx = str.indexOf('&#34;')
    }
    //****************************************************** END Quotation Mark "

    //****************************************************** Apostrophe '
    indx = str.indexOf('&apos;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 6)) , "\'")
        indx = str.indexOf('&apos;')
    }

    indx = str.indexOf('&#39;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\'")
        indx = str.indexOf('&#39;')
    }
    //****************************************************** END Apostrophe '

    //****************************************************** Ampersand &
    indx = str.indexOf('&amp;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\&")
        indx = str.indexOf('&amp;')
    }

    indx = str.indexOf('&#38;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\&")
        indx = str.indexOf('&#38;')
    }
    //****************************************************** END Ampersand &

    //****************************************************** Less-than <
    indx = str.indexOf('&lt;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 4)) , "\<")
        indx = str.indexOf('&lt;')
    }

    indx = str.indexOf('&#60;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\<")
        indx = str.indexOf('&#60;')
    }
    //****************************************************** END Less-than <

    //****************************************************** Greater-than >
    indx = str.indexOf('&gt;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 4)) , "\>")
        indx = str.indexOf('&gt;')
    }

    indx = str.indexOf('&#62;')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 5)) , "\>")
        indx = str.indexOf('&#62;')
    }
    //****************************************************** END Greater-than >

    //console.log(str)

    return str;
}


function removeBackSlashT(str){

    //****************************************************** remove \t
    var indx
    indx = str.indexOf('\t')
    while(indx !== -1){
        str = str.replace(str.substring(indx , (indx + 1)) , "")
        indx = str.indexOf('\t')
    }

    return str;
    //****************************************************** End remove \t

}
