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
top="|[home]($Url) | [code]($Git) | [discuss]($Git/issues) | [license](/LICENSE) |"
banner="<img style=\"width:100%;\" src=\"https://raw.githubusercontent.com/timm/fun/master/etc/img/fun1.png\">"
footer="_&copy; $When;, $Who, $Where _"

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
  sub(/^CODE /,"")         { if(!Code) print "```awk"; Code=1; print $0; next }
  sub(/^DOC /,"")          { if( Code) print "```";    Code=0 }
  BEGIN                    { print  "---\ntitle: " name "\n---\n\n"banner "\n\n" top "\n\n# " name }
  NR < 3                   { next }
                           { print } 
  END                      { if (Code) print "```"; print "\n\n"footer } '
}
gen() { gawk ' 
  function prep(s) {
    print gensub(/\.([^0-9])([a-zA-Z0-9_]*)/, 
                  "[\"\\1\\2\"]","g",s) } 
   
  sub(/^DOC /,"#")         { print; next }
                           { gsub(/(CODE |#.*|[ \t]*$)/,"")   }
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
	$banner

        $top

	# Site Map

	EOF
   for i in $Doc/*.md; do f=$(basename $i); echo "- [$f]($f)" ; done 
   echo
   echo $footer
}
# ----------------------------------------
# do the work

## if command line is "0", blast all prior product
if [ "$1" == "--new" ]; then rm -rf $Lib/* $Bin/* $Doc/*; shift ; fi

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
  (toc > $Doc/index.md)
done

chmod +x $files $Bin/*

if [ "$1" == "--pull" ]; then git pull;                                    exit; fi
if [ "$1" == "--push" ]; then git commit -am commit; git push; git status; exit; fi
if [ -z "$1"         ]; then                                              exit; fi

f=$(basename $1)
f=$Lib/${f%.$Ext}.awk

shift
AWKPATH="$Lib:$AWKPATH" gawk -f $f $*
