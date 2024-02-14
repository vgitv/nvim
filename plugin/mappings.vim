if exists("g:loaded_mappings")
    finish
endif
let g:loaded_mappings = 1

" leader variables
let mapleader = " "
let localleader = "\\"

inoremap <tab> <esc>
inoremap <esc> <nop>

vnoremap <tab> <esc>
vnoremap <esc> <nop>

inoremap <c-space> <tab>

" F-keys

" F1 dans vim sert à éditer l'aide

" compilation date en cyan
" nnoremap <F4> :!echo -e "\033[1;36m`date`\033[00m"<CR>:make!<CR>
nnoremap <F4> :!xbuild %<CR>

" exécution date en vert : penser à ajouter une règle make au makefile :
" run:
"   ./truc
nnoremap <F5> :!make run<CR>

" F6 pour indenter tout le fichier et revenir à l'endroit
nnoremap <F6> mzgg=G`zzz
inoremap <F6> <ESC>mzgg=G`zzza

" ajouter point virgule en fin de ligne ou ligne d'avant en insertion
nnoremap <F7> mzA;<ESC>`z
inoremap <F7> <ESC>kA;<ESC>j==A

" toggle relative number
nnoremap <F8> :set relativenumber!<CR>

" éxecuter le fichier courant par gnuplot
nnoremap <F9> :!gnuplot -p %<CR>

" supprimer les retours charriot
nnoremap <F12> mz:%s/\r//g<CR>`z



" Spécial sequences

" Changer de buffer.
nnoremap <CR> :bnext<CR>
nnoremap <BS> :bprevious<CR>

" modifier la hauteur / largeur de la fenêtre
nnoremap <Up> :resize +1<CR>
nnoremap <Down> :resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Left> :vertical resize -1<CR>



" Control sequences

" Next replace
inoremap <buffer> <c-b> <Esc>/<++><CR>"_c4l

" inverser maj / min d'un mot
inoremap <C-_> <ESC>mzbviw~`za
nnoremap <C-_> mzviw~`z

" insérer ligne vide
nnoremap <C-N> o<Esc>


" Override commands

" switch window
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" search / replace
" replace in all file (in normal mode, S is same as cc so it can be used)
nnoremap S :%s/



" Leader+symbol commands

" sélectionner un mot
nnoremap <Leader><space> viw

" entourer" de " ' ( [ { _ *
nnoremap <Leader>" mzviw<Esc>a"<Esc>bi"<Esc>`zl
nnoremap <Leader>' mzviw<Esc>a'<Esc>bi'<Esc>`zl
nnoremap <Leader>( mzviw<Esc>a)<Esc>bi(<Esc>`zl
nnoremap <Leader>[ mzviw<Esc>a]<Esc>bi[<Esc>`zl
nnoremap <Leader>{ mzviw<Esc>a}<Esc>bi{<Esc>`zl
nnoremap <Leader>_ mzviw<Esc>a_<Esc>bi_<Esc>`zl
nnoremap <Leader>* mzviw<Esc>a*<Esc>bi*<Esc>`zl
nnoremap <Leader>` mzviw<Esc>a`<Esc>bi`<Esc>`zl

vnoremap <Leader>" <Esc>`<i"<Esc>`>la"<Esc>
vnoremap <Leader>' <Esc>`<i'<Esc>`>la'<Esc>
vnoremap <Leader>( <Esc>`<i(<Esc>`>la)<Esc>
vnoremap <Leader>[ <Esc>`<i[<Esc>`>la]<Esc>
vnoremap <Leader>{ <Esc>`<i{<Esc>`>la}<Esc>
vnoremap <Leader>_ <Esc>`<i_<Esc>`>la_<Esc>
vnoremap <Leader>* <Esc>`<i*<Esc>`>la*<Esc>
vnoremap <Leader>` <Esc>`<i`<Esc>`>la`<Esc>

" Buffer alternatif.
nnoremap <Leader># :buffer #<CR>



" Leader+letter commands

" Tout selectionner
nnoremap <Leader>a ggVG

" Choisir un buffer.
nnoremap <Leader>b :ls<CR>:buffer<Space>

" Delete buffer
nnoremap <Leader>d :bnext<CR>:bdelete #<CR>

" editer ~/.vimrc
" nnoremap <Leader>e :tabedit ~/.config/nvim/ftplugin/<C-R>=my_filetype<CR>.vim<CR> :split $MYVIMRC<CR>
nnoremap <Leader>e :vsplit $MYVIMRC<CR>

" toggle foldcolumn
nnoremap <Leader>f :call FoldColumnToggle()<CR>

" next git conflict (git go)
nnoremap <Leader>gg /<<<<<<< HEAD<CR>
" git accept ours (git ours)
nnoremap <Leader>go "_dd/=======<CR>V/>>>>>>><CR>"_d
" git accept theirs (git theirs)
nnoremap <Leader>gt V/=======<CR>"_d/>>>>>>><CR>"_dd

" clean paragraph
nnoremap <Leader>gq mz{V}gq`z

" syntax from start
nnoremap <Leader>h :syntax sync fromstart<CR>

" descendre d'une ligne
nnoremap <Leader>j ddp==

" monter d'une ligne
nnoremap <Leader>k ddkP==

" load MYVIMRC
nnoremap <Leader>l :source $MYVIMRC<CR>

" NerdTree focus
nnoremap <leader>n :NERDTreeFocus<CR>

" toggle quick fix window
nnoremap <Leader>q :call QuickfixToggle()<CR>

" toggle hlsearch
nnoremap <Leader>s :set hlsearch!<CR>:set hlsearch?<CR>

" toggle NerdTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" chercher le mot sous le curseur
nnoremap <Leader>w mzviwy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>
vnoremap <Leader>w mzy<Esc>_/<C-R>"<CR><CR>`z:set hlsearch<CR>

" yank / paste
" yank/paste into/from system clipboard
" vnoremap <Leader>y "*y :let @+=@*<CR>
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p

" paste in visual mode without overwriting global register
" gv<Esc> at the end in order to replace cursor at the end of pasted text
vnoremap p pgvygv<Esc>

" make file executable
nnoremap <Leader>x :!chmod u+x %<CR>



" opérateurs

" inside next (
onoremap in( :<C-U>normal! f(vi(<CR>
" inside previous (last) (
" Not using ip because it would shadow paragraph movement
onoremap il( :<C-U>normal! F)vi(<CR>

" in next email adress
onoremap in@ :<c-u>normal! f@viW<cr>
