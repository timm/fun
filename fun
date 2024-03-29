#!/usr/bin/env bash

# ---------------------------------------
# why fun? why not?

#          _____
#      _-~~     ~~-_//
#    /~             ~\
#   |              _  |_
#  |         _--~~~ )~~ )___
# \|        /   ___   _-~   ~-_
# \          _-~   ~-_         \
# |         /         \         |
# |        |           |     (O  |
#  |      |             |        |
#  |      |   O)        |       |
#  /|      |           |       /
#  / \ _--_ \         /-_   _-~)
#    /~    \ ~-_   _-~   ~~~__/
#   |   |\  ~-_ ~~~ _-~~---~  \
#   |   | |    ~--~~  / \      ~-_
#    |   \ |                      ~-_
#     \   ~-|                        ~~--__ _-~~-,
#      ~-_   |                             /     |
#         ~~--|                                 /
#           |  |                               /
#           |   |              _            _-~
#           |  /~~--_   __---~~          _-~
#           |  \                   __--~~
#           |  |~~--__     ___---~~
#           |  |      ~~~~~
#           |  |

# ---------------------------------------
# the following can be set by external settings "AUK*"
Ext=${AUKEXT:-fun}

gitroot=$(git rev-parse --show-toplevel)
Root=${AUKROOT:-$gitroot}
Lib=${AUKLIB:-$HOME/opt/$Ext/awk}
Bin=${AUKBIN:-$HOME/opt/$Ext/bin}
Doc=${AUKDOC:-$Root/docs/}
Url=${AUKURL:-"http://menzies.us/fun"}
Git=${AUKGIT:-"http://github.com/timm/fun"}
When=${AUKWHEN:-2019}
Who=${AUKWHO:-Tim Menzies}
Where=${AUKWHERE:-"http://menzies.us"}
Git=${AUKGIT:-"http://github.com/timm/fun"}


top="<button class=\"button button1\"><a href=\"/fun/index\">home</a></button>   <button class=\"button button2\"><a href=\"/fun/INSTALL\">install</a></button>   <button class=\"button button1\"><a href=\"/fun/ABOUT\">doc</a></button>   <button class=\"button button2\"><a href=\"$Git/issues\">discuss</a></button>    <button class=\"button button1\"><a href=\"/fun/LICENSE\">license</a></button> "
banner="<img style=\"width:100%;\" src=\"https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png\">"
footer="<em> &copy; $When $Who. ${Where}</em>"

# end config
# ----------------------------------------
# generate executables

parse() { gawk '
  /^@include/              { print "CODE "$0; next }
  /^(func|BEGIN|END).*}$/  { print "CODE "$0; next }
  /^(func|BEGIN|END)/,/^}/ { print "CODE "$0; next }
                           { print "DOC " $0} '
}
doc() {  gawk -v name="$1" -v path="$2" -v banner="$banner" -v top="$top" -v footer="$footer" ' 
  sub(/^CODE @include[ \t]*/,"") { $0=gensub(/"([^"]*)"/,"Uses:  \"[\\1](\\1)\"<br>","g",$0) }
  sub(/^CODE /,"")         { if(!Code) print "```awk"; Code=1; print sprintf("%4s.  ",++N) $0; next }
  sub(/^DOC /,"")          { if( Code) print "```";    Code=0 }
  BEGIN                    { print  "---\ntitle: " name "\n---\n\n"top "<br>\n\n" xbanner  xfooter "\n\n# " name }
  NR < 4                   { next }
  sub(/^#!class /,"")       { print "<img src=\"http://yuml.me/diagram/plain;dir:lr/class/"$0"\">"; next}
                           { print }
  END                      { if (Code) print "```";  } '
}
gen() { gawk ' 
  function prep(s) {
    print gensub(/\.([^0-9])([a-zA-Z0-9_]*)/, 
                  "[\"\\1\\2\"]","g",s) } 
   
  sub(/^DOC /,"#")         { print; next }
                           { gsub(/(CODE |[ \t]*$)/,"")   }
  /^@include/              { prep($0); next }
  /^(func|BEGIN|END).*}$/  { prep($0); next }
  /^(func|BEGIN|END)/,/^}/ { prep($0); next }
                           { print "# " $0  } '
}

toc() {
  cd $Doc; cat <<-EOF
	---
	title: Contents
	---
	$top<br>
        $xbanner<br>
	$xfooter

	EOF
   if [ -f "$Root/src/README.md" ]; then
      cat $Root/src/README.md
   fi
   cat <<-EOF

	## Funny Stuff

	EOF
   for i in $(ls $Doc/[^A-Z]*.md); do 
        ok="ok\.md$"
    	if [[ ! $i =~ $ok ]]; then
          f=$(basename $i)
 	   g=${f%.*}
    	  echo "- [$g]($f): " ; 
          grep "^##" $i  | head -1 | sed 's/^##//'
        fi 
   done
   echo ""
   echo "---"
   echo ""
}
_c0="\033[00m"     # white
_c1="\033[01;32m"  # green
_c2="\033[01;34m"  # blue
_c3="\033[31m"     # red
_c5="\033[35m"     # purple
_c6="\033[33m"     # yellow
_c7="\033[36m"     # turquoise
_c8="\033[96m"     # magenta


help() { echo -en "${_c3}"; 
	 echo -e "usage: ../fun [Option]${_c6}"
	 cat<<-'EOF'

	Options:
	../fun New      set up config files; do only once
	../fun Test     run all the *.ok files
	../fun Push     push source to Github
	../fun Pull     grab source from Github
	../fun Help     print this text
	../fun xxx.fun  run xxx.fun (but first, update all files)
	../fun          update all files
EOF
	echo -en "${_c0}"
}

# ----------------------------------------
# do the work

## if command line is "0", blast all prior product
if [ "$1" = "New" ]; then rm -rf $Lib/*.awk $Bin/* $Doc/*.md; shift ; fi

mkdir -p $Lib $Bin $Doc

files=$(find $Root -name "*.$Ext")

for i in $files;do
  f=$(basename $i)
  stem=${f%.$Ext}
  lib1=$Lib/$stem.awk
  doc1=$Doc/$stem.md
  bin1=$Bin/$stem
  if [ "$i" -nt "$lib1" ]; then cat $i | parse | gen > $lib1; fi
  if [ "$i" -nt "$doc1" ]; then cat $i | parse | doc $f $Url > $doc1; fi
  if [ "$lib1" -nt "$bin1" ]; then
    echo '#!/usr/bin/env gawk -f ' > $bin1
    cat $lib1 >> $bin1
  fi
done

toc > $Doc/index.md
chmod +x $files $Bin/*

if   [ "$1" = "Test" ]
then for f in $Root/src/*ok.fun; do 
       echo ""; echo "---| $(basename $f) |------------"; echo "";
       $Root/fun $f
     done |  gawk '
     1 
     $2 ~ /PASSED/ {p++} 
     $2 ~ /FAILED/ {f++} 
     END           {print "#PASSED: " p " FAILED: " f " %: " int(p*100/(p+f+0.001))
                    if (f> 1) exit 1
                   }'
     exit $?
elif [ "$1" = "Pull" ]
then git pull;                                    
elif [ "$1" = "Push" ]
then git commit -am commit; git push; git status; 
elif [ "$1" = "Help" ]
then help
elif [ -n "$1"       ] 
then  f=$(basename $1)
      f=$Lib/${f%.$Ext}.awk
      AWKPATH="$Lib:$AWKPATH" gawk -f $f $*
fi
