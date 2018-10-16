using Entidades;
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
            PedidoLoQueSeaE p = new PedidoLoQueSeaE();
            p.IdPedido = DateTime.Today.Day.ToString() + DateTime.Today.Month.ToString() + DateTime.Today.Year.ToString() + DateTime.Today.Hour.ToString() + DateTime.Today.Second.ToString();
            p.Descripcion = txtPedido.Text.Trim();
            p.CostoTotal = decimal.Parse(txtCostoPedido.Text.Trim());
            if (cbMapa.Checked)
            {
                string coor = txtCoordenadas.Text.Trim().Replace("(", "").Replace(")", "");
                p.LatitudComercio = coor.Substring(0, coor.IndexOf(",") - 1);
                p.LongitudComercio = coor.Substring(coor.IndexOf(",") + 1);
            }
            else
            {
                p.Callecomercio = txtCalle.Text.Trim();
                p.NumeroComercio = int.Parse(txtNumero.Text.Trim());
                p.CodPostalComercio = txtCodPostal.Text.Trim();
                if (txtPiso.Text.Trim() != "")
                    p.PisoComercio = int.Parse(txtPiso.Text.Trim());
                if (txtDepartamento.Text.Trim() != "")
                    p.DepartamentoComercio = txtDepartamento.Text.Trim();
            }

            string ruta = Server.MapPath("~/temp/" + p.IdPedido);
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

                Session["pedido"] = p;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al guardar el pedido";
                return;
            }

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