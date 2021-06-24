package controllers

import (
	beego "github.com/beego/beego/v2/server/web"
	"shotstand/models"
)

type GroupController struct {
	beego.Controller
}

func (c *GroupController) Get() {

	c.Data["json"] = models.GetShotdata()
	err := c.ServeJSON()
	if err != nil {
		return
	}
}
