import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import 'font-awesome/css/font-awesome.min.css'

router.beforeEach(function(to,from,next){
    let gridMember = sessionStorage.getItem('gridMember');
    if(to.path=='/feedbackList'||to.path=='/feedbackInfo'){
        if(gridMember==null){
            router.push('/login');
        }
    }
    next();
});

createApp(App).use(router).mount('#app')
