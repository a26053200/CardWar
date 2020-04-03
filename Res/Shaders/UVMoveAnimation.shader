// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Game/UVMoveAnimation"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
        _FPS("fps", Range(1,60)) = 30
        _Row("row", float) = 1
        _Col("col", float) = 1
        _Cutout("Alpha CutOut", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" "RenderType" = "TransparentCutOut"}
        //ZWrite On
        Blend SrcAlpha OneMinusSrcAlpha
        //Cull Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma target 3.0
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float _FPS;
            float _Row;
            float _Col;
            float _Cutout;

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
          
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }
            
            fixed4 frag(v2f i) : SV_Target
            {
                fixed2 uv = i.uv;
                //用浮点计算
                fixed frameWidth = 1.0 / _Col;
                fixed frameHeight = 1.0 / _Row;
                fixed2 s = fixed2(uv.x / _Col, uv.y / _Row);
                fixed frameCount = _Row * _Col;
                fixed totalFrame = _Time.y * _FPS;
                fixed index = fmod(totalFrame, frameCount);
                fixed rowIndex = floor(index / _Col);
                fixed colIndex = fmod(index, _Col);
                uv.x = s.x + colIndex * frameWidth;
                uv.y = s.y + rowIndex * frameHeight;
                
                fixed4 col = tex2D(_MainTex, uv);
                //clip(col.a - _Cutout);
                return col * _Color;
            }
            ENDCG
        }
    }
    Fallback "Mobile/Diffuse"
}
