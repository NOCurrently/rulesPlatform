package com.xc.vo;

import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * 菜单资源
 *
 * @author tangwei
 */
@Data
@Valid
public class ResourceTree implements Serializable, Comparable<ResourceTree> {
    /**
     * 资源id
     */
    private Integer id;

    /**
     * 资源编码
     */
    @NotBlank(message = "资源编码不能为空")
    private String code;

    /**
     * 资源名称
     */
    @NotBlank(message = "资源名称不能为空")
    private String name;

    /**
     * 资源状态
     */
    private Integer status;

    /**
     * 备注说明
     */
    private String remark;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 资源路径
     */
    private String url;

    /**
     * 资源类型
     */
    private String type;

    /**
     * 资源父id
     */
    private Integer pid;

    /**
     * 资源创建时间
     */
    private Date createTime;

    /**
     * 资源图标
     */
    private String icon;

    /**
     * 资源树
     */
    private List<ResourceTree> treeList;

    /**
     * 按照sort排序
     *
     * @param o
     * @return
     */
    @Override
    public int compareTo(ResourceTree o) {
        return this.sort - o.getSort();
    }
}