package routers

import (
	beego "github.com/beego/beego/v2/server/web"
	"shotstand/controllers"
)

func init() {
	//beego.Router("/", &controllers.MainController{})
	beego.Router("/", &controllers.HomeController{})

	beego.Router("/enter", &controllers.EnterController{})
	beego.Router("/eintrag", &controllers.EnterController{})
	beego.Router("/eingabe", &controllers.EnterController{})

	beego.Router("/getGroups", &controllers.GroupController{})
	beego.Router("/getTotal", &controllers.TotalController{})
}
