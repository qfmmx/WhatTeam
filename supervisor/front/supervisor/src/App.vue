<template>
  <router-view/>
</template>

<style>
html,body,div,span,h1,h2,h3,h4,h5,h6,ul,ol,li,p{
    margin: 0;
    padding: 0;
}
html,body{
    width: 100%;
    height: 100%;
    font-family: "微软雅黑";
    background: #f0f0f0;
    display: flex;
    align-items: center;
    justify-content: center;
}
#app{
    width: 375px;
    height: 812px;
    background: #fff;
    border-radius: 0;
    box-shadow: 0 0 0 1px #ddd;
    overflow: hidden;
    position: relative;
}
ul,ol{
    list-style: none;
}
a{
    text-decoration: none;
}

.header-box{
    width: 100%;
}
.header-box header{
    width: 100%;
    height: 56px;
    background-color: #FFF;
    color: #555;

    display: flex;
    align-items: center;
    justify-content: space-between;
    box-sizing: border-box;
    padding: 0 13px;

    position: fixed;
    left: 0;
    top: 0;
}
.header-box .top-ban{
    width: 100%;
    height: 56px;
}
.header-box img{
    width: 100%;
    display: block;
    height: 128px;
}
.header-box .fa{
    font-size: 28px;
}

footer{
    width: 100%;
    position: absolute;
    left: 0;
    bottom: 0;
}
footer img{
    width: 100%;
    display: block;
    height: 100px;
}
</style>
