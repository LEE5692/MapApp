package myapp.myapp.myapp;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HomeDao {
	
	@Autowired
	@Resource(name="SqlSession")
	private SqlSession query;
	
	public List getAttractionData() {
		return query.selectList("query.getAttractionData");
	}
}
