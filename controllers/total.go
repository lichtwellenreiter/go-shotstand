package controllers

import (
	beego "github.com/beego/beego/v2/server/web"
	"shotstand/models"
)

type TotalController struct {
	beego.Controller
}

func (c *TotalController) Get() {

	c.Data["json"] = models.GetTotal()
	err := c.ServeJSON()
	if err != nil {
		return
	}
}
