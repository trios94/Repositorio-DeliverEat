using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entidades
{
    public class PedidoLoQueSeaE
    {
        public string IdPedido { get; set; }
        public string Descripcion { get; set; }
        public string Callecomercio { get; set; }
        public Nullable<int> NumeroComercio { get; set; }
        public string CodPostalComercio { get; set; }
        public Nullable<int> PisoComercio { get; set; }
        public string DepartamentoComercio { get; set; }
        public string LatitudComercio { get; set; }
        public string LongitudComercio { get; set; }
        public Nullable<decimal> CostoTotal { get; set; }
        public string CalleRecepcion { get; set; }
        public Nullable<int> NumeroRecepcion { get; set; }
        public string CodPostalRecepcion { get; set; }
        public Nullable<int> PisoRecepcion { get; set; }
        public string DepartamentoRecepcion { get; set; }
        public Nullable<bool> EnvioPrioritario { get; set; }
        public string FechaRecepcion { get; set; }
        public string HoraRecepcion { get; set; }
        public Nullable<bool> PagoTarjeta { get; set; }
        public Nullable<decimal> AbonaEfectivo { get; set; }
        public Nullable<decimal> Vuelto { get; set; }
        public string TitularTarjeta { get; set; }
        public string NumeroTarjeta { get; set; }
        public string VencimientoTarjeta { get; set; }
        public string CodSeguridadTarjeta { get; set; }
    }
}
