" node plugins


" python3 plugins
call remote#host#RegisterPlugin('python3', 'C:/Users/akiya/.cache/dein/.cache/init.vim/.dein/rplugin/python3/defx', [
      \ {'sync': v:true, 'name': '_defx_do_action', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_defx_init', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_defx_start', 'type': 'function', 'opts': {}},
     \ ])
call remote#host#RegisterPlugin('python3', 'C:/Users/akiya/.cache/dein/.cache/init.vim/.dein/rplugin/python3/denite', [
      \ {'sync': v:true, 'name': '_denite_init', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_denite_start', 'type': 'function', 'opts': {}},
      \ {'sync': v:true, 'name': '_denite_do_action', 'type': 'function', 'opts': {}},
     \ ])
call remote#host#RegisterPlugin('python3', 'C:/Users/akiya/.cache/dein/.cache/init.vim/.dein/rplugin/python3/deoplete', [
      \ {'sync': v:false, 'name': '_deoplete_init', 'type': 'function', 'opts': {}},
     \ ])


" ruby plugins


" python plugins


