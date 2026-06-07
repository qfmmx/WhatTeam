import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

import 'font-awesome/css/font-awesome.min.css'

router.beforeEach(function(to,from,next){
    let supervisor = sessionStorage.getItem('supervisor');
    if(to.path!='/login' && to.path!='/register'){
        if(supervisor==null){
            router.push('/login');
            return;
        }
    }
    next();
});

createApp(App).use(router).mount('#app')
