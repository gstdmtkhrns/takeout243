package cn.edu.shu.xj.ser.mapper;


import cn.edu.shu.xj.ser.entity.Student;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

@Component
public interface StudentMapper {

    /**
     * @param sid
     * @return
     */
    @Select("select * from student where id =#{sid}")
    Student findOneStudent(@Param("sid") Integer sid);
}
