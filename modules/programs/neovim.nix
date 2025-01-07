_:{
  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
     vim.opt.langmap = "ΑA,BT,CX,DC,EK,FE,GG,HM,IL,JY,KN,LU,MH,NJ,O:,:P,PR,QQ,RS,SD,TF,UI,VV,WW,XZ,YO,ZB,aa,bt,cx,dc,ek,fe,gg,hm,il,jy,kn,lu,mh,nj,o:,pr,qq,rs,sd,tf,ui,vv,zb,ww,xz,yo";
     vim.keymap.set('n', ';', 'p')
     vim.opt.background = "dark";
     vim.opt.clipboard = "unnamedplus";
     vim.opt.list = true;
     vim.opt.number = true;
     vim.opt.cmdheight = 0;
     vim.opt.cursorline = true;
     vim.opt.relativenumber = true;
     vim.opt.shiftwidth = 2;
     vim.opt.autochdir = true;
     vim.opt.ignorecase = true;
     vim.opt.showmode = false;
     vim.opt.smartindent = true;
     vim.opt.splitbelow = true;
     vim.opt.splitright = true;
     vim.opt.tabstop = 2;
     vim.opt.termguicolors = true;
     vim.opt.updatetime = 300;
     vim.opt.wrap = true;
    '';
  };
}
