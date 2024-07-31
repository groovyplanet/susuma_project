package com.susuma.category.model;

import java.util.ArrayList;

public interface CategoryMapper {

	public ArrayList<CategoryDTO> selectCategorys(String rootNo);

}
