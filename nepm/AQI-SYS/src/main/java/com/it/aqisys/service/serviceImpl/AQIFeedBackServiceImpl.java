package com.it.aqisys.service.serviceImpl;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.it.aqisys.enums.AQI;
import com.it.aqisys.mapper.AQIFeedBackMapper;
import com.it.aqisys.pojo.AQIFeedBack;
import com.it.aqisys.pojo.vo.AQIFeedBackDetailVo;
import com.it.aqisys.pojo.vo.AQIFeedBackQueryVo;
import com.it.aqisys.pojo.vo.AQIFeedBackVo;
import com.it.aqisys.service.AQIFeedBackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AQIFeedBackServiceImpl extends ServiceImpl<AQIFeedBackMapper, AQIFeedBack>
        implements AQIFeedBackService {
    @Autowired
    private AQIFeedBackMapper aqiFeedBackMapper;
    @Override
    public IPage<AQIFeedBackVo>  pageItem(Page<AQIFeedBackVo> page, AQIFeedBackQueryVo queryVo) {
         return aqiFeedBackMapper.pageItem(page,queryVo);
    }

    @Override
    public AQIFeedBackDetailVo getFeedBackDetail(Integer afId) {
        return aqiFeedBackMapper.getFeedBackDetail(afId);
    }

    @Override
    public void assignFeedBack(String gridMemberId, Integer afId) {
        aqiFeedBackMapper.assignFeedBack(gridMemberId,afId);
    }

    @Override
    public void updateState(Integer id, Integer state) {
        AQIFeedBack aqiFeedBack = new AQIFeedBack();
        aqiFeedBack.setAfId(id);
        aqiFeedBack.setState(state);
        aqiFeedBackMapper.updateById(aqiFeedBack);
    }
}
