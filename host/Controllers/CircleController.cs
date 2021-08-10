using Microsoft.AspNetCore.Mvc;
using ShapesClassLibrary;

namespace SimpleK8sHosting.Controllers
{
    [ApiController]
    public class CircleController : ControllerBase
    {
        [HttpGet]
        [Route("[controller]/{radius}")]
        public double Get(int radius)
        {
            return new Circle().Area(radius);
        }
    }
}
