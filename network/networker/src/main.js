import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import Vant from 'vant'
import 'vant/lib/index.css'

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

const app = createApp(App)
app.use(router)
app.use(Vant)
app.mount('#app')