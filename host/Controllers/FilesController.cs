using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Threading.Tasks;

namespace SimpleK8sHosting.Controllers
{
    [ApiController]
    public class FilesController : ControllerBase
    {
        [HttpGet]
        [Route("[controller]/{fileName}")]
        public async Task<IActionResult> Get(string fileName)
        {
            Stream s= new FileStream(fileName, FileMode.Open, FileAccess.Read);
            return Ok(s);
            //return File(s, "application/octet-stream");
        }
    }
}
