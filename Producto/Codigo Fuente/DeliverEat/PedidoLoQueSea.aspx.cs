using AccesoDatos;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliverEat
{
    public partial class PedidoLoQueSea : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
                txtCostoPedido.Text = "0";
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            AccesoDatos.PedidoLoQueSea p = new AccesoDatos.PedidoLoQueSea();
            try
            {
                using (var db = new DeliverEatEntities())
                {
                    AccesoDatos.PedidoLoQueSea ultimoPedido = db.PedidoLoQueSea.OrderByDescending(ped => ped.IdPedido).FirstOrDefault();
                    p.IdPedido = ultimoPedido.IdPedido + 1;
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al generar id del pedido";
                return;
            }

            p.Descripcion = txtPedido.Text.Trim();
            p.CostoTotal = decimal.Parse(txtCostoPedido.Text.Trim());
            if (cbMapa.Checked)
            {
                string coor = txtCoordenadas.Text.Trim().Replace("(", "").Replace(")", "");
                p.Latitud = coor.Substring(0, coor.IndexOf(",") - 1);
                p.Longitud = coor.Substring(coor.IndexOf(",") + 1);
            }
            else
            {
                p.Calle = txtCalle.Text.Trim();
                p.Numero = int.Parse(txtNumero.Text.Trim());
                p.CodPostal = txtCodPostal.Text.Trim();
                if (txtPiso.Text.Trim() != "")
                    p.Piso = int.Parse(txtPiso.Text.Trim());
                if (txtDepartamento.Text.Trim() != "")
                    p.Departamento = txtDepartamento.Text.Trim();
            }

            p.PedidoAbierto = true;
            p.FechaPedido = DateTime.Today;
            List<AccesoDatos.ImagenPedidoLoQueSea> imagenes = new List<ImagenPedidoLoQueSea>();
            string ruta = Server.MapPath("~/temp/" + p.IdPedido.ToString());
            try
            {

                HttpFileCollection hfc = Request.Files;
                if (fileUploader1.HasFiles)
                {
                    // Si el directorio no existe, crearlo
                    if (!Directory.Exists(ruta))
                        Directory.CreateDirectory(ruta);
                }
                for (int i = 0; i < hfc.Count; i++)
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        hpf.SaveAs(Server.MapPath("/temp/" + p.IdPedido.ToString() + "/" + hpf.FileName.ToString()));

                    }
                }

                using (var db = new DeliverEatEntities())
                {
                    db.PedidoLoQueSea.Add(p);
                    db.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar el pedido";
                return;
            }

            Session["pedido"] = p;
            Response.Redirect("ConfirmacionLoQueSea.aspx");
        }

        protected void cbMapa_CheckedChanged(object sender, EventArgs e)
        {
            if (cbMapa.Checked)
            {
                RequiredFieldValidator3.Enabled = false;
                RequiredFieldValidator4.Enabled = false;
                RequiredFieldValidator5.Enabled = false;
                txtCoordenadas.ReadOnly = true;
                txtCoordenadas.Focus();
            }
            else
            {
                RequiredFieldValidator3.Enabled = true;
                RequiredFieldValidator4.Enabled = true;
                RequiredFieldValidator5.Enabled = true;
            }

        }

        
    }
}