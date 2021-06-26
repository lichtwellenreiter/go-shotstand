package controllers

import (
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/go-redis/redis/v8"
	"shotstand/models"
)

type ResetController struct {
	beego.Controller
}

func (c *ResetController) Get() {
	c.TplName = "reset.tpl"
}

func (c *ResetController) Post() {
	flash := beego.NewFlash()

	models.ResetShotdata()

	flash.Notice("Shotcounter zurückgesetzt")
	flash.Store(&c.Controller)
	c.Redirect("/enter", 302)
}
